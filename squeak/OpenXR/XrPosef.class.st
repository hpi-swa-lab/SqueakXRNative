Class {
	#name : #XrPosef,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrPosef class >> fields [

	^ #(
		(orientation 'XrQuaternionf')
		(position 'XrVector3f')
	)
]
