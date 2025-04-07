Class {
	#name : #XrCompositionLayerDepthInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerDepthInfoKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(subImage 'XrSwapchainSubImage')
		(minDepth 'float')
		(maxDepth 'float')
		(nearZ 'float')
		(farZ 'float')
	)
]
