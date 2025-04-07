Class {
	#name : #XrActionSetCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionSetCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(actionSetName 'char[64]')
		(localizedActionSetName 'char[128]')
		(priority 'uint32_t')
	)
]
