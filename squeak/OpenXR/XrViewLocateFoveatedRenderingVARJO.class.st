Class {
	#name : #XrViewLocateFoveatedRenderingVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrViewLocateFoveatedRenderingVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(foveatedRenderingActive 'XrBool32')
	)
]
