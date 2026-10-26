Class {
	#name : #XrEventDataUserPresenceChangedEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataUserPresenceChangedEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(isUserPresent 'XrBool32')
	)
]
