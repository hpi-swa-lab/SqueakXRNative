Class {
	#name : #XrBodySkeletonFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrBodySkeletonFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointCount 'uint32_t')
		(joints 'XrBodySkeletonJointFB*')
	)
]
