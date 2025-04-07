Class {
	#name : #XrSessionActionSetsAttachInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSessionActionSetsAttachInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(countActionSets 'uint32_t')
		(actionSets 'XrActionSet*')
	)
]
