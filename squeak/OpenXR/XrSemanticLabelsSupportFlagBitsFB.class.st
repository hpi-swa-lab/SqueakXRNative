Class {
	#name : #XrSemanticLabelsSupportFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrSemanticLabelsSupportFlagBitsFB class >> XR_SEMANTIC_LABELS_SUPPORT_ACCEPT_DESK_TO_TABLE_MIGRATION_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrSemanticLabelsSupportFlagBitsFB class >> XR_SEMANTIC_LABELS_SUPPORT_ACCEPT_INVISIBLE_WALL_FACE_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrSemanticLabelsSupportFlagBitsFB class >> XR_SEMANTIC_LABELS_SUPPORT_MULTIPLE_SEMANTIC_LABELS_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrSemanticLabelsSupportFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
