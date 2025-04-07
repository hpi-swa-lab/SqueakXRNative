Class {
	#name : #XrActiveActionSetPriorityEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrActiveActionSetPriorityEXT class >> fields [

	^ #(
		(actionSet 'XrActionSet')
		(priorityOverride 'uint32_t')
	)
]
