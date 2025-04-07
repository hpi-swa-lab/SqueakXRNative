Class {
	#name : #XrSpaceVelocities,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceVelocities class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(velocityCount 'uint32_t')
		(velocities 'XrSpaceVelocityData*')
	)
]
