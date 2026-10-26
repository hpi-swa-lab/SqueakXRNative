Class {
	#name : #XrGraphicsBindingEGLMNDX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
