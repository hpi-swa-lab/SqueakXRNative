Class {
	#name : #XrGraphicsBindingOpenGLXlibKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsBindingOpenGLXlibKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(xDisplay 'void*')
		(visualid 'uint32_t')
		(glxFBConfig 'void')
		(glxDrawable 'void')
		(glxContext 'void')
	)
]
