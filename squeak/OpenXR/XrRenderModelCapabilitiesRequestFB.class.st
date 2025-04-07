Class {
	#name : #XrRenderModelCapabilitiesRequestFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrRenderModelCapabilitiesRequestFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrRenderModelFlagsFB')
	)
]
