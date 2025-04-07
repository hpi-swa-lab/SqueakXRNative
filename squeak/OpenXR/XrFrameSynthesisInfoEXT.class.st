Class {
	#name : #XrFrameSynthesisInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameSynthesisInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrFrameSynthesisInfoFlagsEXT')
		(motionVectorSubImage 'XrSwapchainSubImage')
		(motionVectorScale 'XrVector4f')
		(motionVectorOffset 'XrVector4f')
		(appSpaceDeltaPose 'XrPosef')
		(depthSubImage 'XrSwapchainSubImage')
		(minDepth 'float')
		(maxDepth 'float')
		(nearZ 'float')
		(farZ 'float')
	)
]
