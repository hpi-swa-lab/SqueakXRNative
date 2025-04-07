Class {
	#name : #XrSystemUserPresencePropertiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemUserPresencePropertiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsUserPresence 'XrBool32')
	)
]
