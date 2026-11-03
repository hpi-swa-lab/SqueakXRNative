Class {
	#name : #XrVirtualKeyboardTextureDataMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVirtualKeyboardTextureDataMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textureWidth 'uint32_t')
		(textureHeight 'uint32_t')
		(bufferCapacityInput 'uint32_t')
		(bufferCountOutput 'uint32_t')
		(buffer 'uint8_t*')
	)
]
