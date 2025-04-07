Class {
	#name : #XrFaceExpressionStatusFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFaceExpressionStatusFB class >> fields [

	^ #(
		(isValid 'XrBool32')
		(isEyeFollowingBlendshapesValid 'XrBool32')
	)
]
