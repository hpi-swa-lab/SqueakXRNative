Class {
	#name : #XrGraphicsBindingOpenGLWin32KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrGraphicsBindingOpenGLWin32KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(hDC 'void')
		(hGLRC 'void')
	)
]
