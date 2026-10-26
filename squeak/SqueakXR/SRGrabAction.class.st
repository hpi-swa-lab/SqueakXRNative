Class {
	#name : #SRGrabAction,
	#superclass : #SRHandAction,
	#instVars : [
		'grabbedObject',
		'grabbedRelativeTransform'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:24'
}
SRGrabAction >> dragGrabbedObject [
	grabbedObject ifNotNil: [ 
		grabbedObject dragTo: self hand cursor grabbingTransform * grabbedRelativeTransform 
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:27'
}
SRGrabAction >> isGrabbing [ 

	^ grabbedObject isNil not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:50'
}
SRGrabAction >> prepareGrab: target [
	
	target ifNil: [^self].
	grabbedRelativeTransform := self hand cursor grabbingTransform inverseTransformation * target globalTransform.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:56'
}
SRGrabAction >> run: inputState [

	inputState squeeze isJustPressed ifTrue: [ | target |
		target := self hand cursorTarget ifNil: [^true].
		target := target grabTarget.
		target canGrab ifFalse: [^true].
		self prepareGrab: target.
		self startGrabbing: target
	].
	inputState squeeze isJustReleased ifTrue: [ self stopGrabbing ].
	self dragGrabbedObject.
	
	^ self isGrabbing not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 16:49'
}
SRGrabAction >> startGrabbing: target [

	grabbedObject := target.
	grabbedObject startGrabbing: self hand.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:25'
}
SRGrabAction >> stopGrabbing [ 

	grabbedObject ifNotNil: [ grabbedObject stopGrabbing: self hand ].
	grabbedObject := nil.
]
