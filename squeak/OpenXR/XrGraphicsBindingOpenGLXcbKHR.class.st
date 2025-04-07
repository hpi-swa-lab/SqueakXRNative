Class {
	#name : #XrGraphicsBindingOpenGLXcbKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsBindingOpenGLXcbKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(connection 'void*')
		(screenNumber 'uint32_t')
		(fbconfigid 'void*')
		(visualid 'void*')
		(glxDrawable 'void*')
		(glxContext 'void*')
	)
]
