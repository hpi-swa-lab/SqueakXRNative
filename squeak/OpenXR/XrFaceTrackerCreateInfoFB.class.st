Class {
	#name : #XrFaceTrackerCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFaceTrackerCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(faceExpressionSet 'XrFaceExpressionSetFB')
	)
]
