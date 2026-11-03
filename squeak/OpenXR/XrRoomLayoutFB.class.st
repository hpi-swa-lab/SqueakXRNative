Class {
	#name : #XrRoomLayoutFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
