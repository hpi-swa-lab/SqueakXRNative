Class {
	#name : #XrSpaceSaveInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceSaveInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(location 'XrSpaceStorageLocationFB')
		(persistenceMode 'XrSpacePersistenceModeFB')
	)
]
