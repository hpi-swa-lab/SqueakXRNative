Class {
	#name : #XrEventDataVirtualKeyboardCommitTextMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataVirtualKeyboardCommitTextMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(keyboard 'XrVirtualKeyboardMETA')
		(text 'char[3992]')
	)
]
