Class {
	#name : #XrSceneBoundsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
