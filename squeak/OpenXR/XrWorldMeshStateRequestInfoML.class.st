Class {
	#name : #XrWorldMeshStateRequestInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshStateRequestInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(boundingBoxCenter 'XrPosef')
		(boundingBoxExtents 'XrExtent3DfEXT')
	)
]
