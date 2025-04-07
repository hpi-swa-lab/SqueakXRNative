Class {
	#name : #XrSystemColorSpacePropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemColorSpacePropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(colorSpace 'XrColorSpaceFB')
	)
]
