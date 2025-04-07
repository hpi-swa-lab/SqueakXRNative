Class {
	#name : #XrGraphicsRequirementsD3D11KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsRequirementsD3D11KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(adapterLuid 'void')
		(minFeatureLevel 'void')
	)
]
