Class {
	#name : #SRXrInput,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRXrInput class >> fields [

	" self defineFields "

	^ #(
		(actionSet 'XrActionSet')
		(handPoseAction 'XrAction')
	)
]
