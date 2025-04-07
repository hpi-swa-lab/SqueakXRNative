Class {
	#name : #XrSystemSpatialEntitySharingPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemSpatialEntitySharingPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsSpatialEntitySharing 'XrBool32')
	)
]
