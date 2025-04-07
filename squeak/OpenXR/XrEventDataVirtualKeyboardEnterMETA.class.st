Class {
	#name : #XrEventDataVirtualKeyboardEnterMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataVirtualKeyboardEnterMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(keyboard 'XrVirtualKeyboardMETA')
	)
]
