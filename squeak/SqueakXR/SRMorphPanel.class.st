Class {
	#name : #SRMorphPanel,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture',
		'lastClickPosition',
		'detachedMorph'
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
	#category : #refreshing,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMorphPanel class >> refreshAll [
	"Answer how many panels of the live world were refreshed."

	| world |
	world := SRWorld current.
	world ifNil: [^ 0].
	^ world runBetweenFrames: [
		| n |
		n := 0.
		world
			allDescendantsSelect: [:obj | obj isMorphPanel]
			thenDo: [:panel | panel fullTextureUpdate. n := n + 1].
		n]
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
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMorphPanel >> addCustomMenuItemsTo: aMenu [
	super addCustomMenuItemsTo: aMenu.
	aMenu
		addItem: 'Refresh Texture'
		action: [self world
			ifNil: [self fullTextureUpdate]
			ifNotNil: [:w | w runBetweenFrames: [self fullTextureUpdate]]]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:12'
}
SRMorphPanel >> detachedMorph [
	"The Morph kept across a removal, see #wasRemoved."

	^ detachedMorph
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMorphPanel >> fullTextureUpdate [

	morph ifNil: [^ self].

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	texture fullUpdate.
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
	#'squeak_changestamp' : 'MCPServer 8/10/2026 13:54'
}
SRMorphPanel >> initialize [

	super initialize.
	
	plane := SRPlane new
		rotation: (Quaternion angle: 90 axis: Vector3 right);
		addDependent: self;
		yourself.
	texture := SRMorphTexture new.
	lastClickPosition := nil.

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
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:12'
}
SRMorphPanel >> onWorldChanged: oldWorld [

	super onWorldChanged: oldWorld.
	self world ifNotNil: [self remountMorph]
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:32'
}
SRMorphPanel >> remountMorph [
	"Undo #wasRemoved. #morph: sets the isInMorphPanel flag before the Morph reaches
	Morphic again, which is what stops SRPasteUpMorph>>addedMorph: from building a
	second panel for it. Nowhere to put it means stay detached rather than lose it."

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
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/15/2026 13:54'
}
SRMorphPanel >> renderOn: aSRRenderer [

	self morph ifNil: [^ self].
	self updateTexture.
	super renderOn: aSRRenderer.
]

{ #category : #rendering }
SRMorphPanel >> setSizeFromPixelsPerMeter: aNumber [

	plane scale: (self morph width / aNumber) @ 1 @ (self morph height / aNumber)
]

{ #category : #rendering }
SRMorphPanel >> update: aSymbol with: anObject [

	aSymbol = #raycast ifTrue: [self handleRaycast: anObject]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/15/2026 14:13'
}
SRMorphPanel >> updateTexture [

	plane material internalTexture: texture update.
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:32'
}
SRMorphPanel >> wasRemoved [
	"Take the Morph out of Morphic, but remember it so #remountMorph can put it back.
	#removeMorph first: it clears the flag SRPasteUpMorph>>removedMorph: tests, so the
	delete cannot bounce back here."

	detachedMorph := morph.
	self removeMorph.
	detachedMorph ifNotNil: [:each | each delete]
]
