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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:28'
}
SRMorphPanel class >> systemBrowser [

	^ self new
		morph: SystemBrowser default open dependents first
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:28'
}
SRMorphPanel class >> transcript [

	^ self new
		morph: Transcript open dependents first
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/13/2026 14:54'
}
SRMorphPanel class >> workspace [

	^ self new
		morph: Workspace open dependents first
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 2/23/2026 11:38'
}
SRMorphPanel >> fullTextureUpdate [

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	texture fullUpdate.
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 3/25/2026 18:28'
}
SRMorphPanel >> handleRaycast: intersectionResult [

	| normalizedPoint clickPoint point downEvent upEvent |
	self morph ifNil: [^ self].
	
	self world keyboardFocus: self.
	self morph isSystemWindow ifTrue: [self morph beKeyWindow].
	
	point := plane globalTransform globalPointToLocal: intersectionResult point.
	normalizedPoint := point xz asPoint + 0.5 asPoint.
	clickPoint := (normalizedPoint * (self morph extent)) + self morph topLeft.
	
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
		self morph processEvent: upEvent].
	
	lastClickPosition := clickPoint asPoint.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 3/17/2026 16:14'
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
	#'squeak_changestamp' : 'lege 3/16/2026 17:40'
}
SRMorphPanel >> morph: aMorph [

	self removeMorph.
	
	morph := aMorph.
	morph lastPanelPosition ifNotNil: [:position |
		self globalTranslation: position].
	morph setIsInMorphPanel.
	texture morph: morph.
	self updateTexture.
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
	#category : #rendering,
	#'squeak_changestamp' : 'lege 3/16/2026 16:32'
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
	#'squeak_changestamp' : 'lege 2/23/2026 11:37'
}
SRMorphPanel >> updateTexture [

	plane material texture: texture update.
	
]
