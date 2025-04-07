Class {
	#name : #XrSwapchainCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrSwapchainCreateFlags')
		(usageFlags 'XrSwapchainUsageFlags')
		(format 'int64_t')
		(sampleCount 'uint32_t')
		(width 'uint32_t')
		(height 'uint32_t')
		(faceCount 'uint32_t')
		(arraySize 'uint32_t')
		(mipCount 'uint32_t')
	)
]
