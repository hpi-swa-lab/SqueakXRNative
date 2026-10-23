Class {
	#name : #XrSwapchainStateSamplerOpenGLESFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainStateSamplerOpenGLESFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(minFilter 'void')
		(magFilter 'void')
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
