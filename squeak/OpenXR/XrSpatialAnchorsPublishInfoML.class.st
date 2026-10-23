Class {
	#name : #XrSpatialAnchorsPublishInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsPublishInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(anchorCount 'uint32_t')
		(anchors 'XrSpace*')
		(expiration 'uint64_t')
	)
]
