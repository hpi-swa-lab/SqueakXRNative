Class {
	#name : #XrWorldMeshDetectorFlagBitsML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_COMPUTE_CONFIDENCE_BIT_ML [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_COMPUTE_NORMALS_BIT_ML [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_INDEX_ORDER_CW_BIT_ML [

	^ self on: (1 bitShift: 5)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_PLANARIZE_BIT_ML [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_POINT_CLOUD_BIT_ML [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> XR_WORLD_MESH_DETECTOR_REMOVE_MESH_SKIRT_BIT_ML [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrWorldMeshDetectorFlagBitsML class >> originalTypeName [

    ^ 'long'
]
