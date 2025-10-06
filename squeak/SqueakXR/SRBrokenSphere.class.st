Class {
	#name : #SRBrokenSphere,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRBrokenSphere >> renderOn: aSRRenderer [

	ThreadSafeRandom next < 0.001 ifTrue: [self error: 'Oopsie!'].
	aSRRenderer renderSphereTransformed: self globalTransform withColor: Color blue.
]
