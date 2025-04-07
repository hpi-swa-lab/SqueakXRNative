Class {
	#name : #XrRenderModelFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrRenderModelFlagBitsFB class >> XR_RENDER_MODEL_SUPPORTS_GLTF_2_0_SUBSET_1_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrRenderModelFlagBitsFB class >> XR_RENDER_MODEL_SUPPORTS_GLTF_2_0_SUBSET_2_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrRenderModelFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
