Class {
	#name : #XrSystemPassthroughColorLutPropertiesMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemPassthroughColorLutPropertiesMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(maxColorLutResolution 'uint32_t')
	)
]
