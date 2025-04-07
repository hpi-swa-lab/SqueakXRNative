Class {
	#name : #XrWindingOrderFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrWindingOrderFB class >> XR_WINDING_ORDER_CCW_FB [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrWindingOrderFB class >> XR_WINDING_ORDER_CW_FB [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrWindingOrderFB class >> XR_WINDING_ORDER_UNKNOWN_FB [

	^ self on: (0)
]

{ #category : #'as yet unclassified' }
XrWindingOrderFB class >> originalTypeName [

    ^ 'long'
]
