Class {
	#name : #XrPassthroughColorMapMonoToRgbaFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorMapMonoToRgbaFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textureColorMap 'XrColor4f[256]')
	)
]
