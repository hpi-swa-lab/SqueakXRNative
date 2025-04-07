Class {
	#name : #XrGraphicsBindingEGLMNDX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsBindingEGLMNDX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(getProcAddress 'PFN_xrEglGetProcAddressMNDX')
		(display 'void')
		(config 'void')
		(context 'void')
	)
]
