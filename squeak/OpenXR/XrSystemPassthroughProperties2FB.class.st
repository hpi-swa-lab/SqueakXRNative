Class {
	#name : #XrSystemPassthroughProperties2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemPassthroughProperties2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(capabilities 'XrPassthroughCapabilityFlagsFB')
	)
]
