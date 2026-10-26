Class {
	#name : #XrHolographicWindowAttachmentMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHolographicWindowAttachmentMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(holographicSpace 'void*')
		(coreWindow 'void*')
	)
]
