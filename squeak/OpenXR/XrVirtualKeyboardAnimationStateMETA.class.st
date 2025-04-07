Class {
	#name : #XrVirtualKeyboardAnimationStateMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardAnimationStateMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(animationIndex 'int32_t')
		(fraction 'float')
	)
]
