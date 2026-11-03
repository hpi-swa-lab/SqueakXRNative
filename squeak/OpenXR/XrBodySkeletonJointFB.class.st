Class {
	#name : #XrBodySkeletonJointFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrBodySkeletonJointFB class >> fields [

	^ #(
		(joint 'int32_t')
		(parentJoint 'int32_t')
		(pose 'XrPosef')
	)
]
