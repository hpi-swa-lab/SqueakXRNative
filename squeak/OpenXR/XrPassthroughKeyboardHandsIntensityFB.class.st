Class {
	#name : #XrPassthroughKeyboardHandsIntensityFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughKeyboardHandsIntensityFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(leftHandIntensity 'float')
		(rightHandIntensity 'float')
	)
]
