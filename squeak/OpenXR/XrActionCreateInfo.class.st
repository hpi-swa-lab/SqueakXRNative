Class {
	#name : #XrActionCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrActionCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(actionName 'char[64]')
		(actionType 'XrActionType')
		(countSubactionPaths 'uint32_t')
		(subactionPaths 'XrPath*')
		(localizedActionName 'char[128]')
	)
]
