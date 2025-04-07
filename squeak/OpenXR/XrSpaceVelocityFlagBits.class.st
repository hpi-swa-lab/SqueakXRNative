Class {
	#name : #XrSpaceVelocityFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceVelocityFlagBits class >> XR_SPACE_VELOCITY_ANGULAR_VALID_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrSpaceVelocityFlagBits class >> XR_SPACE_VELOCITY_LINEAR_VALID_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrSpaceVelocityFlagBits class >> originalTypeName [

    ^ 'long'
]
