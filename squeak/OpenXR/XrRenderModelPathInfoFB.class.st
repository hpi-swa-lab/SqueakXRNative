Class {
	#name : #XrRenderModelPathInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrRenderModelPathInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(path 'XrPath')
	)
]
