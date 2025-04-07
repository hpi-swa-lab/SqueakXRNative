Class {
	#name : #XrSwapchainImageOpenGLKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageOpenGLKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(image 'uint32_t')
	)
]
