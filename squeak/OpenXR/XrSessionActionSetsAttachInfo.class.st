Class {
	#name : #XrSessionActionSetsAttachInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSessionActionSetsAttachInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(countActionSets 'uint32_t')
		(actionSets 'XrActionSet*')
	)
]
