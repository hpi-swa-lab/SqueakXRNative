Class {
	#name : #XrRenderModelLoadInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrRenderModelLoadInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(modelKey 'XrRenderModelKeyFB')
	)
]
