Class {
	#name : #XrWorldMeshRequestCompletionInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshRequestCompletionInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(meshSpace 'XrSpace')
		(meshSpaceLocateTime 'XrTime')
	)
]
