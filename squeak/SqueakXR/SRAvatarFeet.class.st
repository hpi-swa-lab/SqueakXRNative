Class {
	#name : #SRAvatarFeet,
	#superclass : #SRObject,
	#instVars : [
		'leftCube',
		'lastActions'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 16:33'
}
SRAvatarFeet >> actionsUpdated: aSRActionStates [
	lastActions := aSRActionStates

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 16:48'
}
SRAvatarFeet >> initialize [ 
	super initialize.
	Transcript showln: 'Feet ready!'.
	
	leftCube := SRCube new
		scale: 10cm asVector3.
	
	self addChild: leftCube.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 16:42'
}
SRAvatarFeet >> lastActions [
	^ lastActions
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 14:31'
}
SRAvatarFeet >> step: deltaTime [
	| leftStick |
	leftStick := self world avatar leftHand joystick vector.
	self position: leftStick.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 15:53'
}
SRAvatarFeet >> update: aSymbol with: anObject [
	aSymbol = #actionsUpdated ifTrue: [self actionsUpdated: anObject]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 16:33'
}
SRAvatarFeet >> worldChanged: oldWorld [
	super worldChanged: oldWorld.
	
	oldWorld ifNotNil: [
		oldWorld removeDependent: self
	].
	
	"Make sure we are notified of any input events"
	self world addDependent: self.
]
