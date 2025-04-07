Class {
	#name : #XrEventDataVirtualKeyboardCommitTextMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataVirtualKeyboardCommitTextMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(keyboard 'XrVirtualKeyboardMETA')
		(text 'char[3992]')
	)
]
