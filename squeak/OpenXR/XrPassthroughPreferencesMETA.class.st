Class {
	#name : #XrPassthroughPreferencesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughPreferencesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrPassthroughPreferenceFlagsMETA')
	)
]
