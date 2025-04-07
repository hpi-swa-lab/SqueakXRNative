Class {
	#name : #XrInteractionProfileSuggestedBinding,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrInteractionProfileSuggestedBinding class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(interactionProfile 'XrPath')
		(countSuggestedBindings 'uint32_t')
		(suggestedBindings 'XrActionSuggestedBinding*')
	)
]
