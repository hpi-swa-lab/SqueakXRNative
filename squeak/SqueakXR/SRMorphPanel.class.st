Class {
	#name : #SRMorphPanel,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture',
		'lastClickPosition'
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
	#'squeak_changestamp' : 'MCPServer 7/31/2026 17:26'
}
SRMorphPanel class >> refreshAll [
	"Force every SRMorphPanel in the running world to re-measure its plane and fully
	repaint its texture. Answers how many panels were refreshed.

	The repair hatch for a panel that has gone stale: SRMorphTexture repaints from
	Morphic damage rects, and the plane size is only recomputed in
	#fullTextureUpdate -- so a morph that resized, or damage that never reached the
	texture, leaves a panel showing the wrong thing at the wrong size until
	something forces a full update.

	Runs inside SRWorld>>runBetweenFrames:, so it cannot mutate plane scales while
	a frame is mid-render. Discovered by walking the live scene graph rather than
	via #allInstances, so panels of a torn-down world are not touched."
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
	#'squeak_changestamp' : 'MCPServer 7/31/2026 17:26'
}
SRMorphPanel class >> xrMenuRefreshAll: aMenu [
	"Refresh every morph panel in the world (plane size + full texture repaint).
	The pragma is only ever scanned by SRMenuRegistry."
	<xrMenu: #(world) label: 'Refresh Morph Panels' priority: 160>
	^ self refreshAll
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 7/31/2026 17:35'
}
SRMorphPanel >> addCustomMenuItemsTo: aMenu [
	"Panel-specific context-menu items. This menu is reached at all only because the
	panel's plane delegates its #grabTarget to the panel (see #initialize) -- the
	hand ray hits the plane, and without that delegation these items would be
	offered on an SRPlane instead.

	'Refresh Texture' is the single-panel twin of SRMorphPanel class>>refreshAll:
	SRMorphTexture repaints from Morphic damage rects, and the plane size is only
	recomputed in #fullTextureUpdate -- so a panel whose morph resized, or whose
	damage never reached the texture, stays stale until something forces a full
	update.

	Deferred through #runBetweenFrames: rather than run inline: a menu action fires
	from inside a frame, and #fullTextureUpdate rescales the plane."
	super addCustomMenuItemsTo: aMenu.
	aMenu
		addItem: 'Refresh Texture'
		action: [self world
			ifNil: [self fullTextureUpdate]
			ifNotNil: [:w | w runBetweenFrames: [self fullTextureUpdate]]]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 7/31/2026 17:36'
}
SRMorphPanel >> fullTextureUpdate [

	"No morph, nothing to size or paint. Reachable for real: #removeMorph nils morph
	while the panel is still a child of the world (SRPasteUpMorph>>removedMorph:
	removes the morph before the panel), and both the Refresh Texture menu item and
	SRMorphPanel class>>refreshAll walk live panels. Without this,
	#setSizeFromPixelsPerMeter: fails with UndefinedObject>>width."
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:20'
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

	"The plane is what a hand ray actually hits, but it is an implementation
	detail -- grabbing or opening a context menu on it must act on the PANEL.
	SRHand>>startGrabbing resolves the hit through #grabTarget, and the result
	is what SRAvatar>>openMenuForHand: passes to SRMenu class>>contextMenuFor:...,
	so this one line fixes both the grab and the menu. Same delegation
	SWAGameBasePlate does, but set per instance: SRPlane is generic, and plain
	planes must keep answering themselves."
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
	#category : #hierarchy,
	#'squeak_changestamp' : 'MCPServer 7/31/2026 16:00'
}
SRMorphPanel >> removedChild: aSRObject [
	"The plane is the only thing of me a raycast can hit, so it is the plane the
	context menu's Remove reaches, not me. Losing it makes me an invisible shell
	holding a Morph that is still in the Morphic world and still stepping, so
	take the whole panel down instead. self remove clears the morph too."

	aSRObject == plane ifFalse: [^ self].
	self parent
		ifNil: [self wasRemoved]
		ifNotNil: [self remove]
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
	#'squeak_changestamp' : 'MCPServer 7/31/2026 16:00'
}
SRMorphPanel >> wasRemoved [
	"Losing my place in the scene graph takes the Morph with me, whichever route
	detached me. Without this the Morph stays in the Morphic world, invisible but
	still stepping. SRPasteUpMorph>>removedMorph: covers the opposite direction,
	and removeMorph must run before the delete: it clears the Morph's
	isInMorphPanel property, which is exactly the guard removedMorph: tests, so
	the delete cannot bounce back into here."

	| shown |
	shown := morph.
	self removeMorph.
	shown ifNotNil: [shown delete]
]
