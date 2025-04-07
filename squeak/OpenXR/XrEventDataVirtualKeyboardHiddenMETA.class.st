Class {
	#name : #XrEventDataVirtualKeyboardHiddenMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataVirtualKeyboardHiddenMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(keyboard 'XrVirtualKeyboardMETA')
	)
]
