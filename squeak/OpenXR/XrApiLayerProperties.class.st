Class {
	#name : #XrApiLayerProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrApiLayerProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerName 'char[256]')
		(specVersion 'XrVersion')
		(layerVersion 'uint32_t')
		(description 'char[256]')
	)
]
