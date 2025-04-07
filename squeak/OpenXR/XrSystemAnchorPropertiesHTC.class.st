Class {
	#name : #XrSystemAnchorPropertiesHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemAnchorPropertiesHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsAnchor 'XrBool32')
	)
]
