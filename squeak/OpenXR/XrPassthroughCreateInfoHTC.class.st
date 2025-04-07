Class {
	#name : #XrPassthroughCreateInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughCreateInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(form 'XrPassthroughFormHTC')
	)
]
