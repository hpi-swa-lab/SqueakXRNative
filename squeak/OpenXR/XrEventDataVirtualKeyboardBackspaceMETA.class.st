Class {
	#name : #XrEventDataVirtualKeyboardBackspaceMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataVirtualKeyboardBackspaceMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(keyboard 'XrVirtualKeyboardMETA')
	)
]
