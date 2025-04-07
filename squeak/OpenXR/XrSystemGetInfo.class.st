Class {
	#name : #XrSystemGetInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemGetInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(formFactor 'XrFormFactor')
	)
]
