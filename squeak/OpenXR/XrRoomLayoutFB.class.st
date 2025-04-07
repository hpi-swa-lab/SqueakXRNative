Class {
	#name : #XrRoomLayoutFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrRoomLayoutFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(floorUuid 'XrUuidEXT')
		(ceilingUuid 'XrUuidEXT')
		(wallUuidCapacityInput 'uint32_t')
		(wallUuidCountOutput 'uint32_t')
		(wallUuids 'XrUuidEXT*')
	)
]
