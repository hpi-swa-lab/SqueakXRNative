Class {
	#name : #XrBodySkeletonJointFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBodySkeletonJointFB class >> fields [

	^ #(
		(joint 'int32_t')
		(parentJoint 'int32_t')
		(pose 'XrPosef')
	)
]
