Class {
	#name : #XrPassthroughColorMapLutMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorMapLutMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(colorLut 'XrPassthroughColorLutMETA')
		(weight 'float')
	)
]
