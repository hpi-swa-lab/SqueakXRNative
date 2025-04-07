Class {
	#name : #XrSystemEyeGazeInteractionPropertiesEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemEyeGazeInteractionPropertiesEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsEyeGazeInteraction 'XrBool32')
	)
]
