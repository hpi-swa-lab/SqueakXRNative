Class {
	#name : #XrSystemRenderModelPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemRenderModelPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsRenderModelLoading 'XrBool32')
	)
]
