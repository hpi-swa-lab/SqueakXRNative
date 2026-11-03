Class {
	#name : #XrSpaceSaveInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceSaveInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(location 'XrSpaceStorageLocationFB')
		(persistenceMode 'XrSpacePersistenceModeFB')
	)
]
