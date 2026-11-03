Class {
	#name : #XrActiveActionSetPriorityEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrActiveActionSetPriorityEXT class >> fields [

	^ #(
		(actionSet 'XrActionSet')
		(priorityOverride 'uint32_t')
	)
]
