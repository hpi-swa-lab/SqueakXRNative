Class {
	#name : #XrSceneFrustumBoundMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneFrustumBoundMSFT class >> fields [

	^ #(
		(pose 'XrPosef')
		(fov 'XrFovf')
		(farDistance 'float')
	)
]
