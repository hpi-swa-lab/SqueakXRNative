Class {
	#name : #XrShareSpacesRecipientGroupsMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrShareSpacesRecipientGroupsMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(groupCount 'uint32_t')
		(groups 'XrUuid*')
	)
]
