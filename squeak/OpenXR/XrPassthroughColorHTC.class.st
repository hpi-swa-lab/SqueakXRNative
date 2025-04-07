Class {
	#name : #XrPassthroughColorHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(alpha 'float')
	)
]
