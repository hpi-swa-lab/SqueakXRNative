Class {
	#name : #XrSystemFoveatedRenderingPropertiesVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemFoveatedRenderingPropertiesVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsFoveatedRendering 'XrBool32')
	)
]
