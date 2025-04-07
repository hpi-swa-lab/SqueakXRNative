Class {
	#name : #XrDebugUtilsLabelEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrDebugUtilsLabelEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(labelName 'char*')
	)
]
