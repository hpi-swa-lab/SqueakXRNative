Class {
	#name : #SRBrokenSphere,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 10/6/2025 15:20'
}
SRBrokenSphere >> renderOn: aSRRenderer [

	ThreadSafeRandom next < 0.001 ifTrue: [self error: 'Oopsie!'].
	aSRRenderer renderSphereTransformed: self globalTransform withColor: Color blue.
]
