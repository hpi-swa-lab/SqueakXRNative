Class {
	#name : #XrSpatialAnchorsPublishInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsPublishInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(anchorCount 'uint32_t')
		(anchors 'XrSpace*')
		(expiration 'uint64_t')
	)
]
