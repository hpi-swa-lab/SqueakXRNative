Class {
	#name : #XrBodySkeletonHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodySkeletonHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointCount 'uint32_t')
		(joints 'XrBodySkeletonJointHTC*')
	)
]
