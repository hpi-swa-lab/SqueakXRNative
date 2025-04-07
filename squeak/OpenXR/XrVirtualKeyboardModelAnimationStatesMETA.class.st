Class {
	#name : #XrVirtualKeyboardModelAnimationStatesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardModelAnimationStatesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(stateCapacityInput 'uint32_t')
		(stateCountOutput 'uint32_t')
		(states 'XrVirtualKeyboardAnimationStateMETA*')
	)
]
