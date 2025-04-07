Class {
	#name : #XrSystemVirtualKeyboardPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemVirtualKeyboardPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsVirtualKeyboard 'XrBool32')
	)
]
