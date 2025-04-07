Class {
	#name : #XrActiveActionSetPrioritiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrActiveActionSetPrioritiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(actionSetPriorityCount 'uint32_t')
		(actionSetPriorities 'XrActiveActionSetPriorityEXT*')
	)
]
