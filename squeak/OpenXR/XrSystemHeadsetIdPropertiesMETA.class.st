Class {
	#name : #XrSystemHeadsetIdPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemHeadsetIdPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(id 'XrUuidEXT')
	)
]
