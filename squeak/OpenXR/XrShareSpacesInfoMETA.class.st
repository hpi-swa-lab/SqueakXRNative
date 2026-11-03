Class {
	#name : #XrShareSpacesInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrShareSpacesInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
		(recipientInfo 'XrShareSpacesRecipientBaseHeaderMETA*')
	)
]
