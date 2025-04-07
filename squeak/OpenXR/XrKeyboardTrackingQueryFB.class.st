Class {
	#name : #XrKeyboardTrackingQueryFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrKeyboardTrackingQueryFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrKeyboardTrackingQueryFlagsFB')
	)
]
