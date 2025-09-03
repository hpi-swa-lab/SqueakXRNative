Class {
	#name : #SRMorphProjection,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture',
		'needsTextureUpdate',
		'lastClickPosition'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRMorphProjection class >> defaultPixelsPerMeter [

	^ 500
]

{ #category : #events }
SRMorphProjection >> handleRaycast: intersectionResult [

	| normalizedPoint clickPoint point downEvent upEvent |
	self world keyboardFocus: self.
	
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
	
	Project current addDeferredUIMessage: [[
		self morph
			processEvent: downEvent;
			processEvent: upEvent]
				on: ProvideAnswerNotification
				do: [:n | Transcript showln: 'During raycast click: '; show: n. n resume: true].
		self needsTextureUpdate].
	
	lastClickPosition := clickPoint asPoint.
]

{ #category : #initialization }
SRMorphProjection >> initialize [

	super initialize.
	
	plane := SRPlane new
		addDependent: self;
		yourself.
	texture := SRMorphTexture new.
	needsTextureUpdate := false.
	lastClickPosition := nil.
	
	self addChild: plane.
]

{ #category : #events }
SRMorphProjection >> keyboardEvent: aCharacter [

	| buttons event keyValue |
	buttons := 0.
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftShift)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightShift])
		ifTrue: [buttons := buttons bitOr: 2r0001].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftControl)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightControl])
		ifTrue: [buttons := buttons bitOr: 2r0100].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftAlt)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightAlt])
		ifTrue: [buttons := buttons bitOr: 2r1000].
	((Raylib isKeyDownKey: RlKeyboardKey keyLeftSuper)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightSuper])
		ifTrue: [buttons := buttons bitOr: 2r0010].
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
		self morph processEvent: event]
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
				Transcript showln: 'Exception during keystroke: '; show: exception. exception pass].
			self needsTextureUpdate.].
]

{ #category : #accessing }
SRMorphProjection >> morph [

	^ morph
]

{ #category : #accessing }
SRMorphProjection >> morph: aMorph [

	morph := aMorph.
	
	texture morph: morph.
	self updateTexture.
]

{ #category : #accessing }
SRMorphProjection >> needsTextureUpdate [
	
	"calling this from e.g. the UI thread should be thread-safe"
	needsTextureUpdate := true
	
]

{ #category : #rendering }
SRMorphProjection >> renderOn: aSRRenderer [

	needsTextureUpdate ifTrue: [
		needsTextureUpdate := false.
		self updateTexture].

	super renderOn: aSRRenderer.
]

{ #category : #rendering }
SRMorphProjection >> setSizeFromPixelsPerMeter: aNumber [

	plane setScale: (self morph width / aNumber) @ 1 @ (self morph height / aNumber)
]

{ #category : #rendering }
SRMorphProjection >> update: aSymbol with: anObject [

	aSymbol = #raycast ifTrue: [self handleRaycast: anObject]
]

{ #category : #accessing }
SRMorphProjection >> updateTexture [

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	plane material texture: texture update.
	
]
