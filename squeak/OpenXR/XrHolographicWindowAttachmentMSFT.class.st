Class {
	#name : #XrHolographicWindowAttachmentMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHolographicWindowAttachmentMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(holographicSpace 'void*')
		(coreWindow 'void*')
	)
]
