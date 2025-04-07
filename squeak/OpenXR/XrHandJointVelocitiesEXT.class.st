Class {
	#name : #XrHandJointVelocitiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandJointVelocitiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointCount 'uint32_t')
		(jointVelocities 'XrHandJointVelocityEXT*')
	)
]
