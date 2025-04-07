Class {
	#name : #XrHandTrackingCapsulesStateFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackingCapsulesStateFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(capsules 'XrHandCapsuleFB[19]')
	)
]
