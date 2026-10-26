Class {
	#name : #XrSpatialAnchorsCreateInfoFromUuidsML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsCreateInfoFromUuidsML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(storage 'XrSpatialAnchorsStorageML')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
