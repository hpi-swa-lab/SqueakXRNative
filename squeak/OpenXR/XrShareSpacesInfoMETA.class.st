Class {
	#name : #XrShareSpacesInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrShareSpacesInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
		(recipientInfo 'XrShareSpacesRecipientBaseHeaderMETA*')
	)
]
