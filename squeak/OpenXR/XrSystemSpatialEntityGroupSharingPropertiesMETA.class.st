Class {
	#name : #XrSystemSpatialEntityGroupSharingPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemSpatialEntityGroupSharingPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsSpatialEntityGroupSharing 'XrBool32')
	)
]
