Class {
	#name : #XrCompositionLayerProjectionView,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerProjectionView class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(pose 'XrPosef')
		(fov 'XrFovf')
		(subImage 'XrSwapchainSubImage')
	)
]
