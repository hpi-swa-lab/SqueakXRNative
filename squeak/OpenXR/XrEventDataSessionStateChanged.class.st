Class {
	#name : #XrEventDataSessionStateChanged,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataSessionStateChanged class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(state 'XrSessionState')
		(time 'XrTime')
	)
]
