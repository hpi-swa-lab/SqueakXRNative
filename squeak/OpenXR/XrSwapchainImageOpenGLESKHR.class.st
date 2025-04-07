Class {
	#name : #XrSwapchainImageOpenGLESKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSwapchainImageOpenGLESKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(image 'uint32_t')
	)
]
