Class {
	#name : #XrEventDataUserPresenceChangedEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataUserPresenceChangedEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(isUserPresent 'XrBool32')
	)
]
