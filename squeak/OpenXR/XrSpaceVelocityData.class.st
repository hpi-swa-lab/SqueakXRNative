Class {
	#name : #XrSpaceVelocityData,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceVelocityData class >> fields [

	^ #(
		(velocityFlags 'XrSpaceVelocityFlags')
		(linearVelocity 'XrVector3f')
		(angularVelocity 'XrVector3f')
	)
]
