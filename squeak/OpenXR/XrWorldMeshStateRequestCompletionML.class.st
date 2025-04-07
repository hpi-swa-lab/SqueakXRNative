Class {
	#name : #XrWorldMeshStateRequestCompletionML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshStateRequestCompletionML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(futureResult 'XrResult')
		(timestamp 'XrTime')
		(meshBlockStateCapacityInput 'uint32_t')
		(meshBlockStateCountOutput 'uint32_t')
		(meshBlockStates 'XrWorldMeshBlockStateML*')
	)
]
