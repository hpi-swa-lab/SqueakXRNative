Class {
	#name : #XrSpaceEraseInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceEraseInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(location 'XrSpaceStorageLocationFB')
	)
]
