Class {
	#name : #XrSystemColocationDiscoveryPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemColocationDiscoveryPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsColocationDiscovery 'XrBool32')
	)
]
