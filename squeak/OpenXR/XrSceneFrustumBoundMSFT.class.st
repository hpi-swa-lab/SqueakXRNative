Class {
	#name : #XrSceneFrustumBoundMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneFrustumBoundMSFT class >> fields [

	^ #(
		(pose 'XrPosef')
		(fov 'XrFovf')
		(farDistance 'float')
	)
]
