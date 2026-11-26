Class {
	#name : #SRMorphPanel,
	#superclass : #SRPanel,
	#instVars : [
		'morph',
		'plane',
		'texture',
		'lastClickPosition',
		'detachedMorph',
		'resizers',
		'hoveredMorphs',
		'lastHoverPoint',
		'pressedButton'
	],
	#classVars : [
		'Mesh',
		'PixelsPerMeter'
	],
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:23'
}
SRMorphPanel class >> defaultPixelsPerMeter [
	"Morph extents grow with the desktop scale factor; panels should not."

	^ self pixelsPerMeter * RealEstateAgent scaleFactor
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
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:23'
}
SRMorphPanel class >> pixelsPerMeter [
	<preference: 'XR panel pixels per meter'
		category: 'SqueakXR'
		description: 'How many Morphic pixels make one meter of an XR panel, at desktop scale factor 1. Lower makes panels bigger. The desktop scale factor is divided out, so a high-DPI desktop gives sharper panels, not bigger ones.'
		type: #Number>
	^ PixelsPerMeter ifNil: [500]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:23'
}
SRMorphPanel class >> pixelsPerMeter: aNumber [

	PixelsPerMeter := aNumber.
	self allInstancesDo: [:each | each morph ifNotNil: [each updatePlaneSize]].
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
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:55'
}
SRMorphPanel >> acceptsRightClickAt: aVector [

	^ self morph notNil and: [self morph bounds containsPoint: (self morphPointForGlobalPoint: aVector)]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:41'
}
SRMorphPanel >> addCustomMenuItemsTo: aMenu [
	super addCustomMenuItemsTo: aMenu.
	aMenu
		addItem: 'Refresh Texture'
		action: [self world
			ifNotNil: [:w | w addDeferredFrameMessage: [self fullTextureUpdate]]]
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:48'
}
SRMorphPanel >> addResizerAt: aCornerSymbol [

	| newResizer |
	(self resizerAt: aCornerSymbol) ifNotNil: [:existing | ^ existing].
	newResizer := SRResizer new.
	self addChild: newResizer.
	newResizer panel: self; corner: aCornerSymbol.
	newResizer snapToCorner.
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
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:12'
}
SRMorphPanel >> deliverKeyboardEvent: anEvent [
	"A pop-up menu takes the hand's keyboard focus to be steered with the arrow
	keys, but XR keys arrive at the panel that was clicked."
	| hand |
	hand := self morph world ifNotNil: [:w | w primaryHand].
	(hand notNil and: [hand keyboardFocus isKindOf: MenuMorph])
		ifTrue: [^ hand sendKeyboardEvent: anEvent].
	self morph processEvent: anEvent
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
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:51'
}
SRMorphPanel >> followMorphExtent [
	"A Morph resized from the Morphic side, e.g. right after opening, would otherwise
	keep the old plane and look like a different DPI until the next handle drag."

	| ppm |
	morph ifNil: [^ self].
	(self resizers anySatisfy: [:each | each isDragging]) ifTrue: [^ self].
	ppm := self pixelsPerMeter.
	((plane scale x * ppm) rounded = morph width and: [(plane scale z * ppm) rounded = morph height])
		ifTrue: [^ self].
	self updatePlaneSize; snapResizers.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRMorphPanel >> fullTextureUpdate [

	morph ifNil: [^ self].

	self updatePlaneSize.
	texture source notifyTextureChanged.
	"The Morph may have been resized by something other than a handle."
	self snapResizers.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:49'
}
SRMorphPanel >> getClickPoint: anEvent [

	^ self morphPointForGlobalPoint: anEvent point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 18:56'
}
SRMorphPanel >> globalPointForMorphPoint: aPoint [
	| normalized |
	normalized := (aPoint - self morph topLeft) / self morph extent - 0.5 asPoint.
	^ plane globalTransform localPointToGlobal: normalized x @ 0 @ normalized y
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/16/2026 15:10'
}
SRMorphPanel >> grabTarget: anObject [

	super grabTarget: anObject.
	plane ifNotNil: [plane grabTarget: self grabTarget].
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
	#category : #testing,
	#'squeak_changestamp' : 'jl-MCPServer 11/23/2026 16:25'
}
SRMorphPanel >> hasKeyboardFocus [

	^ self world notNil and: [self world keyboardFocus == self]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 19:06'
}
SRMorphPanel >> holdsStick [
	^ self hasKeyboardFocus
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:12'
}
SRMorphPanel >> hoverAt: aPointOrNil [
	"Squeak's MouseOverHandler hit-tests the whole 2D world, where the morphs of
	different panels overlap at random. Here the pointer is tracked within this
	panel's morph only."
	| hand over event previous |
	previous := hoveredMorphs ifNil: [#()].
	hand := self morph ifNotNil: [:m | m world ifNotNil: [:w | w primaryHand]].
	hand ifNil: [^ hoveredMorphs := nil].
	over := aPointOrNil
		ifNil: [#()]
		ifNotNil: [:point | self morph morphsAt: point].
	event := MouseEvent new
		setType: #mouseOver
		position: (aPointOrNil ifNil: [lastClickPosition ifNil: [self morph center]])
		buttons: 0
		hand: hand.
	event becomeActiveDuring: [
		previous do: [:each |
			(over includes: each) ifFalse: [each handleEvent: event asMouseLeave]].
		over reverseDo: [:each |
			(previous includes: each) ifFalse: [each handleEvent: event asMouseEnter]]].
	hoveredMorphs := over.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:41'
}
SRMorphPanel >> initialize [

	super initialize.
	
	texture := SRTexture withSource: SRTextureSourceMorph new.
	plane := SRPlane new
		rotation: (Quaternion angle: 90 axis: Vector3 right)
					* (Quaternion angle: 180 axis: Vector3 up);
		addDependent: self;
		grabTarget: self;
		cursorMode: SRCursorMode ignore;
		yourself.
	lastClickPosition := nil.
	resizers := OrderedCollection new.

	plane material
		shader: self morphicPanelShader;
		texture: texture.

	plane grabTarget: self.

	self addChild: plane.
	self addResizers.
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
	#'squeak_changestamp' : 'MCPServer (jl) 11/18/2026 19:12'
}
SRMorphPanel >> keyboardEvent: aCharacter [

	| buttons event keyValue |
	self morph ifNil: [^ self].
	buttons := SRDesktopInputState current morphicModifierBits.
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
			self deliverKeyboardEvent: event]]
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
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:51'
}
SRMorphPanel >> morph: aMorph [

	self removeMorph.
	
	morph := aMorph.
	morph lastPanelPosition ifNotNil: [:position |
		self globalTranslation: position].
	morph setIsInMorphPanel.
	morph addDependent: self.
	texture source morph: morph.
	self name: (morph knownName ifNil: [morph class asString]).
	self updatePlaneSize; snapResizers.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:49'
}
SRMorphPanel >> morphPointForGlobalPoint: aVector [

	| normalizedPoint point |
	point := plane globalTransform globalPointToLocal: aVector.
	normalizedPoint := point xz asPoint + 0.5 asPoint.
	^ (normalizedPoint * (self morph extent)) + self morph topLeft
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:49'
}
SRMorphPanel >> morphicButtonFor: anInputEvent controlDown: aBoolean [
	"Ctrl+click is Squeak's right click for a one-button mouse. The simulator's
	own right button is already the grab."
	anInputEvent button == #trigger ifFalse: [^ nil].
	^ aBoolean
		ifTrue: [MouseButtonEvent yellowButton]
		ifFalse: [MouseButtonEvent redButton]
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:12'
}
SRMorphPanel >> morphicHand [
	^ self morph world
		ifNil: [self currentHand]
		ifNotNil: [:world | world primaryHand]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 15:14'
}
SRMorphPanel >> morphicPanelShader [

	^ SRShader morphicPanel
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:24'
}
SRMorphPanel >> mouseDownAt: aPoint button: aButton [
	"Morphic's click-or-drag detection runs on the real hand, far from the ray, and would start a 2D drag-and-drop the panel can never drop."
	| event |
	self morph ifNil: [^ self].
	pressedButton := aButton.
	event := MouseButtonEvent new
		setType: #mouseDown
		position: aPoint
		which: aButton
		buttons: aButton
		nClicks: 1
		hand: self morphicHand
		stamp: Sensor eventTimeNow.
	event becomeActiveDuring: [self morph processEvent: event].
	event hand resetClickState.
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:16'
}
SRMorphPanel >> mouseDragTo: aPoint [
	pressedButton ifNil: [^ self].
	self sendToMouseFocus: (MouseMoveEvent new
		setType: #mouseMove
		startPoint: aPoint
		endPoint: aPoint
		trail: {aPoint}
		buttons: pressedButton
		hand: self morphicHand
		stamp: Sensor eventTimeNow).
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:16'
}
SRMorphPanel >> mouseUpAt: aPoint [
	| button |
	(pressedButton isNil or: [self morph isNil]) ifTrue: [^ self].
	button := pressedButton.
	pressedButton := nil.
	self sendToMouseFocus: (MouseButtonEvent new
		setType: #mouseUp
		position: aPoint
		which: button
		buttons: 0
		nClicks: 1
		hand: self morphicHand
		stamp: Sensor eventTimeNow).
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:45'
}
SRMorphPanel >> mouseWheelEventFor: notches at: aPoint [
	"Morphic counts wheel deltas in VM scroll units, 120 per notch."
	^ MouseWheelEvent new
		setType: #mouseWheel
		position: aPoint
		delta: 0 @ (notches * MouseWheelEvent scrollUnitsPerMouseWheelNotch) rounded
		buttons: SRDesktopInputState current morphicModifierBits
		hand: self currentHand
		stamp: Sensor eventTimeNow
]

{
	#category : #testing,
	#'squeak_changestamp' : 'jl-MCPServer 11/23/2026 16:25'
}
SRMorphPanel >> onAnalogInput: anEvent [

	self morph ifNil: [^self].
	(anEvent axis == #joystick and: [self hasKeyboardFocus]) ifTrue: [ | clickPoint |
		clickPoint := self getClickPoint: anEvent.
		self performScroll: anEvent at: clickPoint.
	].
	anEvent axis == #wheel ifTrue: [
		self performWheel: anEvent at: (self getClickPoint: anEvent)].
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 10/20/2026 14:33'
}
SRMorphPanel >> onButtonPress: anEvent [
	
	| clickPoint |
	self morph ifNil: [^self].
	clickPoint := self getClickPoint: anEvent.
	self performClick: anEvent at: clickPoint.
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:49'
}
SRMorphPanel >> onButtonRelease: anEvent [
	| point |
	self morph ifNil: [^ self].
	anEvent button == #trigger ifFalse: [^ self].
	point := self getClickPoint: anEvent.
	Project current addDeferredUIMessage: [
		SRClickingHandVariable value: anEvent hand during: [
			self mouseUpAt: point]].
	anEvent handled: true.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (leo) 10/15/2026 11:09'
}
SRMorphPanel >> onCacheInvalidated [

	super onCacheInvalidated.

	self fullTextureUpdate.
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:17'
}
SRMorphPanel >> onCursorLeave: anEvent [
	"The release would go to whatever the ray points at next, so a drag ends at the edge."
	| point |
	point := lastHoverPoint.
	lastHoverPoint := nil.
	Project current addDeferredUIMessage: [
		point ifNotNil: [self mouseUpAt: point].
		self hoverAt: nil].
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:24'
}
SRMorphPanel >> onCursorMove: anEvent [
	| point |
	self morph ifNil: [^ self].
	point := (self getClickPoint: anEvent) rounded.
	point = lastHoverPoint ifTrue: [^ self].
	lastHoverPoint := point.
	Project current addDeferredUIMessage: [self pointerMovedTo: point].
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 16:16'
}
SRMorphPanel >> onMorphicWorldEntered [

	super onMorphicWorldEntered.
	self detachMorph; remountMorph
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
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:17'
}
SRMorphPanel >> performClick: anInputEvent at: aPoint [
	| button |
	anInputEvent pressed ifFalse: [^ self].
	button := (self
		morphicButtonFor: anInputEvent
		controlDown: SRDesktopInputState current isControlDown) ifNil: [^ self].
	self world keyboardFocus: self.
	self morph isSystemWindow ifTrue: [self morph beKeyWindow].
	Project current addDeferredUIMessage: [
		SRClickingHandVariable value: anInputEvent hand during: [
			self mouseDownAt: aPoint button: button]].
	lastClickPosition := aPoint.
	anInputEvent handled: true.
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:45'
}
SRMorphPanel >> performScroll: anAnalogEvent at: aPoint [

	Project current addDeferredUIMessage: [ | scrollEvent thumbstickY |
		thumbstickY := anAnalogEvent value y.
		scrollEvent := MouseWheelEvent new
			setType: #mouseWheel
			position: aPoint
			delta: 0@30 * thumbstickY sign
			buttons: 0
			hand: self currentHand
			stamp: Sensor eventTimeNow.
		scrollEvent becomeActiveDuring: [
			self morph processEvent: scrollEvent].
	].
	anAnalogEvent handled: true.
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer (jl) 11/13/2026 15:45'
}
SRMorphPanel >> performWheel: anAnalogEvent at: aPoint [
	| wheelEvent |
	wheelEvent := self mouseWheelEventFor: anAnalogEvent value at: aPoint.
	Project current addDeferredUIMessage: [
		wheelEvent becomeActiveDuring: [
			self morph processEvent: wheelEvent]].
	anAnalogEvent handled: true.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:21'
}
SRMorphPanel >> pixelsPerMeter [

	^ self class defaultPixelsPerMeter
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:24'
}
SRMorphPanel >> pointerMovedTo: aPoint [
	pressedButton
		ifNil: [self hoverAt: aPoint]
		ifNotNil: [self mouseDragTo: aPoint].
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 16:16'
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
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:51'
}
SRMorphPanel >> removeMorph [

	morph ifNotNil: [
		morph setInMorphPanel: false. "assumption: morph is only ever in one morph panel"
		morph lastPanelPosition: self globalTranslation.
		morph removeDependent: self.
		morph := nil.
		texture source morph: nil].
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

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 12:55'
}
SRMorphPanel >> rightClickAt: aVector by: aHand [
	| point |
	point := self morphPointForGlobalPoint: aVector.
	Project current addDeferredUIMessage: [
		SRClickingHandVariable value: aHand during: [
			self
				mouseDownAt: point button: MouseButtonEvent yellowButton;
				mouseUpAt: point]].
]

{
	#category : #events,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:24'
}
SRMorphPanel >> sendToMouseFocus: aMouseEvent [
	"The morph that took the press keeps the drag even when the point leaves it, as with Morphic's own hand."
	| hand focus |
	hand := aMouseEvent hand.
	focus := hand mouseFocus.
	(focus notNil and: [focus == self morph or: [focus hasOwner: self morph]])
		ifFalse: [^ aMouseEvent becomeActiveDuring: [self morph processEvent: aMouseEvent]].
	hand sendFocusEvent: aMouseEvent to: focus clear: [hand releaseMouseFocus: focus].
]

{
	#category : #resizing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRMorphPanel >> snapResizers [
	self resizers do: [:each | each snapToCorner]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:51'
}
SRMorphPanel >> update: aSymbol with: anObject [

	aSymbol = #raycast ifTrue: [self handleRaycast: anObject].
	aSymbol = #worldDrawn ifTrue: [self followMorphExtent].
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:32'
}
SRMorphPanel >> updatePlaneSize [

	| ppm |
	ppm := self pixelsPerMeter.
	plane scale: (self morph width / ppm) @ 1 @ (self morph height / ppm).
]
