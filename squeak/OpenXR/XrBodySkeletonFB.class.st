Class {
	#name : #XrBodySkeletonFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBodySkeletonFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointCount 'uint32_t')
		(joints 'XrBodySkeletonJointFB*')
	)
]
