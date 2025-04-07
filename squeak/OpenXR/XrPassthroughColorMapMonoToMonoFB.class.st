Class {
	#name : #XrPassthroughColorMapMonoToMonoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorMapMonoToMonoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textureColorMap 'uint8_t[256]')
	)
]
