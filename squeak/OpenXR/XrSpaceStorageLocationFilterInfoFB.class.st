Class {
	#name : #XrSpaceStorageLocationFilterInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceStorageLocationFilterInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(location 'XrSpaceStorageLocationFB')
	)
]
