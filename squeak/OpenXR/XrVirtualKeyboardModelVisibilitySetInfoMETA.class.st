Class {
	#name : #XrVirtualKeyboardModelVisibilitySetInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardModelVisibilitySetInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(visible 'XrBool32')
	)
]
