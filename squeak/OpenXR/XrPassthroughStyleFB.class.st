Class {
	#name : #XrPassthroughStyleFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughStyleFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textureOpacityFactor 'float')
		(edgeColor 'XrColor4f')
	)
]
