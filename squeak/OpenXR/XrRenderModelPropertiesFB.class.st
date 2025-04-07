Class {
	#name : #XrRenderModelPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrRenderModelPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(vendorId 'uint32_t')
		(modelName 'char[64]')
		(modelKey 'XrRenderModelKeyFB')
		(modelVersion 'uint32_t')
		(flags 'XrRenderModelFlagsFB')
	)
]
