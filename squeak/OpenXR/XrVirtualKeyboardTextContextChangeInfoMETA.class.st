Class {
	#name : #XrVirtualKeyboardTextContextChangeInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardTextContextChangeInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textContext 'char*')
	)
]
