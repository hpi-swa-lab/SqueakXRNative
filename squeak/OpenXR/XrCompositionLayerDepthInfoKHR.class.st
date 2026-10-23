Class {
	#name : #XrCompositionLayerDepthInfoKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
