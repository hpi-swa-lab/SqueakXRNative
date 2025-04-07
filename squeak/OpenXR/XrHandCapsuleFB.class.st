Class {
	#name : #XrHandCapsuleFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrHandCapsuleFB class >> fields [

	^ #(
		(points 'XrVector3f[2]')
		(radius 'float')
		(joint 'XrHandJointEXT')
	)
]
