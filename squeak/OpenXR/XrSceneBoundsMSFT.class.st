Class {
	#name : #XrSceneBoundsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneBoundsMSFT class >> fields [

	^ #(
		(space 'XrSpace')
		(time 'XrTime')
		(sphereCount 'uint32_t')
		(spheres 'XrSceneSphereBoundMSFT*')
		(boxCount 'uint32_t')
		(boxes 'XrSceneOrientedBoxBoundMSFT*')
		(frustumCount 'uint32_t')
		(frustums 'XrSceneFrustumBoundMSFT*')
	)
]
