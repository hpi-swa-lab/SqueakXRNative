Class {
	#name : #XrSpaceVelocity,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceVelocity class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(velocityFlags 'XrSpaceVelocityFlags')
		(linearVelocity 'XrVector3f')
		(angularVelocity 'XrVector3f')
	)
]
