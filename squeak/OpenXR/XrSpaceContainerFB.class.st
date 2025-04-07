Class {
	#name : #XrSpaceContainerFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceContainerFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCapacityInput 'uint32_t')
		(uuidCountOutput 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
