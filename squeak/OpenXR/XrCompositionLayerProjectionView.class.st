Class {
	#name : #XrCompositionLayerProjectionView,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrCompositionLayerProjectionView class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(pose 'XrPosef')
		(fov 'XrFovf')
		(subImage 'XrSwapchainSubImage')
	)
]
