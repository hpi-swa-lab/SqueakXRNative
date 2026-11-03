Class {
	#name : #XrSpaceContainerFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceContainerFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCapacityInput 'uint32_t')
		(uuidCountOutput 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
