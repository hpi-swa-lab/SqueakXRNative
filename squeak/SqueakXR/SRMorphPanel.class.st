Class {
	#name : #SRMorphPanel,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture',
		'lastClickPosition',
		'detachedMorph',
		'resizers'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Morphic'
}

{ #category : #'as yet unclassified' }
SRMorphPanel class >> defaultPixelsPerMeter [

	^ 500
]

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/11/2026 16:23'
}
SRMorphPanel class >> morphicPanel [
	<shaderSource: #morphicPanel>
	"Squeak Forms come out BGRA."

	^ {
		#frag -> '
#version 450

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;

layout(location = 0) out vec4 finalColor;

void main()
{
      vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
      finalColor = texelColor.bgra;
}'
	} as: Dictionary
]

{
	#category : #refreshing,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 16:23'
}
SRMorphPanel class >> refreshAll [

	| world |
	world := SRWorld current.
	world ifNil: [^ self].
	world addDeferredFrameMessage: [
		world
			allDescendantsSelect: [:obj | obj isMorphPanel]
			thenDo: [:panel | panel fullTextureUpdate]]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:35'
}
SRMorphPanel class >> systemBrowser [

	^ self withoutAddingToWorldDo: [
		self new morph: SystemBrowser default open dependents first]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:35'
}
SRMorphPanel class >> transcript [

	^ self withoutAddingToWorldDo: [
		self new morph: Transcript open dependents first]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:34'
}
SRMorphPanel class >> withoutAddingToWorldDo: aBlock [

	"This prevents Morphs like SystemWindows and the like
	from being added to the SRWorld just because they are opened in the Morphic world."
	
	^ SRIsAddingMorphsToWorldVariable value: false during: aBlock
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/29/2026 17:34'
}
SRMorphPanel class >> workspace [

	^ self withoutAddingToWorldDo: [
		self new morph: Workspace open dependents first]
]

{
	#category : #refreshing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:54'
}
SRMorphPanel class >> xrMenuRefreshAll: aMenu [
	<xrMenu: #(world debug) label: 'Refresh Morph Panels' priority: 420>
	^ self refreshAll
]

{
	#category : #menu,
	#'squeak_changestamp' : 'jl 8/12/2026 13:54'
}
SRMorphPanel >> addCustomMenuItemsTo: aMenu [
	super addCustomMenuItemsTo: aMenu.
	aMenu
		addItem: 'Refresh Texture'
		action: [self world
			ifNotNil: [:w | w addDeferredFrameMessage: [self fullTextureUpdate]]].
	aMenu
		addItem: (self resizers ifEmpty: ['Resize'] ifNotEmpty: [:r | 'Resize (hide handles)'])
		action: [self world
			ifNil: [self toggleResizers]
			ifNotNil: [:w | w addDeferredFrameMessage: [self toggleResizers]]]

]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:53'
}
SRMorphPanel >> addResizerAt: aCornerSymbol [

	| newResizer |
	(self resizerAt: aCornerSymbol) ifNotNil: [:existing | ^ existing].
	newResizer := SRResizer new.
	self addChild: newResizer.
	newResizer panel: self; corner: aCornerSymbol.
	resizers add: newResizer.
	^ newResizer
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRMorphPanel >> addResizers [
	^ SRResizer corners collect: [:each | self addResizerAt: each]
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'jl 8/10/2026 17:51'
}
SRMorphPanel >> detachMorph [

	morph ifNil: [^ self].
	detachedMorph := morph.
	self removeMorph.
	detachedMorph delete
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/11/2026 16:23'
}
SRMorphPanel >> detachedMorph [
	^ detachedMorph
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl 8/12/2026 13:54'
}
SRMorphPanel >> fullTextureUpdate [

	morph ifNil: [^ self].

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	texture fullUpdate.
	"The Morph may have been resized by something other than a handle."
	self snapResizers.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 5/29/2026 14:29'
}
SRMorphPanel >> handleRaycast: intersectionResult [

	| normalizedPoint clickPoint point downEvent upEvent thumbstickY actionState |
	self morph ifNil: [^ self].
	
	self world keyboardFocus: self.
	self morph isSystemWindow ifTrue: [self morph beKeyWindow].
	
	point := plane globalTransform globalPointToLocal: intersectionResult point.
	normalizedPoint := point xz asPoint + 0.5 asPoint.
	clickPoint := (normalizedPoint * (self morph extent)) + self morph topLeft.
	
	Project current addDeferredUIMessage: [
		actionState := intersectionResult actionState.
		(actionState notNil and: [(thumbstickY := actionState thumbstickY first) abs > 0.5])
			ifTrue: [ | scrollEvent |
				scrollEvent := MouseWheelEvent new
					setType: #mouseWheel
					position: clickPoint asPoint
					delta: 0@30 * thumbstickY sign
					buttons: 0
					hand: self currentHand
					stamp: Sensor eventTimeNow.
				scrollEvent becomeActiveDuring: [
					self morph processEvent: scrollEvent].]
			ifFalse: [
				downEvent := MouseButtonEvent new
					setType: #mouseDown
					position: clickPoint asPoint
					which: MouseButtonEvent redButton
					buttons: MouseButtonEvent redButton
					nClicks: 1
					hand: self currentHand
					stamp: Sensor eventTimeNow.
				upEvent := MouseButtonEvent new
					setType: #mouseUp
					position: clickPoint asPoint
					which: MouseButtonEvent redButton
					buttons: MouseButtonEvent redButton
					nClicks: 1
					hand: self currentHand
					stamp: Sensor eventTimeNow.
					
				downEvent becomeActiveDuring: [
					self morph processEvent: downEvent].
				upEvent becomeActiveDuring: [
					self morph processEvent: upEvent]].].
	
	lastClickPosition := clickPoint asPoint.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:53'
}
SRMorphPanel >> initialize [

	super initialize.
	
	plane := SRPlane new
		rotation: (Quaternion angle: 90 axis: Vector3 right);
		addDependent: self;
		yourself.
	texture := SRMorphTexture new.
	lastClickPosition := nil.
	resizers := OrderedCollection new.

	plane material shader: texture shader.

	plane grabTarget: self.

	self addChild: plane.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 3/16/2026 16:15'
}
SRMorphPanel >> isMorphPanel [

	^ true
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 3/25/2026 18:25'
}
SRMorphPanel >> keyboardEvent: aCharacter [

	| buttons event keyValue |
	self morph ifNil: [^ self].
	buttons := 0.
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftShift)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightShift])
		ifTrue: [buttons := buttons bitOr: 2r0001].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftControl)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightControl])
		ifTrue: [buttons := buttons bitOr: 2r0010].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftAlt)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightAlt])
		ifTrue: [buttons := buttons bitOr: 2r1000].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftSuper)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightSuper])
		ifTrue: [buttons := buttons bitOr: 2r0100].
	buttons := buttons bitShift: MouseEvent numButtons.
	keyValue := aCharacter asInteger.
	
	event := KeyboardEvent new
		setType: #keystroke
		buttons: buttons
		position: (lastClickPosition ifNil: [self morph center])
		keyValue: keyValue
		keyCode: keyValue
		hand: self currentHand
		stamp: Sensor eventTimeNow.
	
	Project current addDeferredUIMessage: [[
		event becomeActiveDuring:[
			self morph processEvent: event]]
		on: Error
		do: [:error |
			Transcript showln: 'Error occurred during keystroke: '; show: error. error pass]
		on: ProvideAnswerNotification
		do: [:notification |
			notification messageText = 'Please type your initials:'
				ifTrue: [notification resume: 'xr user']
				ifFalse: [notification pass]]
		on: Exception
		do: [:exception |
			Transcript showln: 'Exception during keystroke: '; show: exception. exception pass]].
]

{ #category : #accessing }
SRMorphPanel >> morph [

	^ morph
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 16:34'
}
SRMorphPanel >> morph: aMorph [

	self removeMorph.
	
	morph := aMorph.
	morph lastPanelPosition ifNotNil: [:position |
		self globalTranslation: position].
	morph setIsInMorphPanel.
	texture morph: morph.
	self updateTexture;
		name: (morph knownName ifNil: [morph class asString]).
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 3/11/2026 16:39'
}
SRMorphPanel >> onCacheInvalidated [

	super onCacheInvalidated.

	texture resetTexture.
	self fullTextureUpdate.
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'jl 8/10/2026 17:51'
}
SRMorphPanel >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	self world
		ifNil: [self detachMorph]
		ifNotNil: [self remountMorph]
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'jl 8/10/2026 17:51'
}
SRMorphPanel >> remountMorph [

	| detached morphicWorld |
	detachedMorph ifNil: [^ self].
	morphicWorld := self world ifNotNil: [:world | world morphicWorld].
	morphicWorld ifNil: [^ self].
	detached := detachedMorph.
	detachedMorph := nil.
	detached lastPanelPosition: self globalTranslation.
	self morph: detached.
	morphicWorld addMorph: detached.
	^ detached
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 3/16/2026 17:40'
}
SRMorphPanel >> removeMorph [

	morph ifNotNil: [
		morph setInMorphPanel: false. "assumption: morph is only ever in one morph panel"
		morph lastPanelPosition: self globalTranslation.
		morph := nil.
		texture removeMorph].
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:53'
}
SRMorphPanel >> removeResizers [

	resizers do: [:each | each remove].
	resizers := OrderedCollection new.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/15/2026 13:54'
}
SRMorphPanel >> renderOn: aSRRenderer [

	self morph ifNil: [^ self].
	self updateTexture.
	super renderOn: aSRRenderer.
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 18:00'
}
SRMorphPanel >> resizerAt: aCornerSymbol [

	^ self resizers
		detect: [:each | each corner = aCornerSymbol]
		ifNone: [nil]
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:53'
}
SRMorphPanel >> resizers [

	^ resizers
]

{ #category : #rendering }
SRMorphPanel >> setSizeFromPixelsPerMeter: aNumber [

	plane scale: (self morph width / aNumber) @ 1 @ (self morph height / aNumber)
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRMorphPanel >> snapResizers [
	self resizers do: [:each | each snapToCorner]
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 18:00'
}
SRMorphPanel >> toggleResizers [

	self resizers
		ifEmpty: [self addResizers]
		ifNotEmpty: [self removeResizers]
]

{ #category : #rendering }
SRMorphPanel >> update: aSymbol with: anObject [

	aSymbol = #raycast ifTrue: [self handleRaycast: anObject]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl 8/11/2026 15:49'
}
SRMorphPanel >> updateTexture [

	texture update ifNotNil: [:each |
		plane material internalTexture: each].
]
