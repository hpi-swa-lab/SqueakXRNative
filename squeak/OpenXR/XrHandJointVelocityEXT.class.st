Class {
	#name : #XrHandJointVelocityEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandJointVelocityEXT class >> fields [

	^ #(
		(velocityFlags 'XrSpaceVelocityFlags')
		(linearVelocity 'XrVector3f')
		(angularVelocity 'XrVector3f')
	)
]
