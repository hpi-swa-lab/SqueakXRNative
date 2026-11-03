Class {
	#name : #XrSceneObjectTypesFilterInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneObjectTypesFilterInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(objectTypeCount 'uint32_t')
		(objectTypes 'XrSceneObjectTypeMSFT*')
	)
]
