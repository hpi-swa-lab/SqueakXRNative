Class {
	#name : #XrVirtualKeyboardModelAnimationStatesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVirtualKeyboardModelAnimationStatesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(stateCapacityInput 'uint32_t')
		(stateCountOutput 'uint32_t')
		(states 'XrVirtualKeyboardAnimationStateMETA*')
	)
]
