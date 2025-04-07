Class {
	#name : #XrSpaceListSaveInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceListSaveInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
		(location 'XrSpaceStorageLocationFB')
	)
]
