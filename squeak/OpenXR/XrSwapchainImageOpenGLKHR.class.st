Class {
	#name : #XrSwapchainImageOpenGLKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainImageOpenGLKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(image 'uint32_t')
	)
]
