Class {
	#name : #XrGraphicsRequirementsMetalKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsRequirementsMetalKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(metalDevice 'void*')
	)
]
