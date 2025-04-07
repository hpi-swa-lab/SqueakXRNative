Class {
	#name : #XrSystemSpatialEntityPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemSpatialEntityPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsSpatialEntity 'XrBool32')
	)
]
