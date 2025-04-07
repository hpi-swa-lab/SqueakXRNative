Class {
	#name : #XrVirtualKeyboardTextureDataMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
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
