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
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:28'
}
SRGrabAction >> perform: inputState [

	inputState squeeze isJustPressed ifTrue: [ self startGrabbing ].
	inputState squeeze isJustReleased ifTrue: [ self stopGrabbing ].
	self dragGrabbedObject.
	
	^ self isGrabbing not
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:23'
}
SRGrabAction >> startGrabbing [ 

	| target |
	target := self hand cursorTarget ifNil: [ ^ self ].
	target canGrab ifFalse: [^self].
	grabbedObject := target.
	grabbedRelativeTransform := self hand cursor grabbingTransform inverseTransformation * grabbedObject globalTransform.
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
