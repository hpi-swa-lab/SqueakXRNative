Class {
	#name : #XrSwapchainStateSamplerVulkanFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainStateSamplerVulkanFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minFilter 'void')
		(magFilter 'void')
		(mipmapMode 'void')
		(wrapModeS 'void')
		(wrapModeT 'void')
		(swizzleRed 'void')
		(swizzleGreen 'void')
		(swizzleBlue 'void')
		(swizzleAlpha 'void')
		(maxAnisotropy 'float')
		(borderColor 'XrColor4f')
	)
]
