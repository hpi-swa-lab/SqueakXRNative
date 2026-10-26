Class {
	#name : #XrActionSetCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrActionSetCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(actionSetName 'char[64]')
		(localizedActionSetName 'char[128]')
		(priority 'uint32_t')
	)
]
