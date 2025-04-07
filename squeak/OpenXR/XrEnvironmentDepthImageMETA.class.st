Class {
	#name : #XrEnvironmentDepthImageMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthImageMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(swapchainIndex 'uint32_t')
		(nearZ 'float')
		(farZ 'float')
		(views 'XrEnvironmentDepthImageViewMETA[2]')
	)
]
