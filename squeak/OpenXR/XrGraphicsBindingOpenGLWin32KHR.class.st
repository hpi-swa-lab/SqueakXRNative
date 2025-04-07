Class {
	#name : #XrGraphicsBindingOpenGLWin32KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsBindingOpenGLWin32KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(hDC 'void')
		(hGLRC 'void')
	)
]
