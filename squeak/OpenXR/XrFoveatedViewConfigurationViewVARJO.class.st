Class {
	#name : #XrFoveatedViewConfigurationViewVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveatedViewConfigurationViewVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(foveatedRenderingActive 'XrBool32')
	)
]
