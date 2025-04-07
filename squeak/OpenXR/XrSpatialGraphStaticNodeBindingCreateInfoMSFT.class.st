Class {
	#name : #XrSpatialGraphStaticNodeBindingCreateInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialGraphStaticNodeBindingCreateInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
		(time 'XrTime')
	)
]
