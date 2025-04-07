Class {
	#name : #XrFaceExpressionInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFaceExpressionInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(time 'XrTime')
	)
]
