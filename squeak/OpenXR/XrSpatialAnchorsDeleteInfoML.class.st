Class {
	#name : #XrSpatialAnchorsDeleteInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsDeleteInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuidCount 'uint32_t')
		(uuids 'XrUuidEXT*')
	)
]
