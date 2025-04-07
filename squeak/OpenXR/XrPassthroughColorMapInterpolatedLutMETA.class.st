Class {
	#name : #XrPassthroughColorMapInterpolatedLutMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorMapInterpolatedLutMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sourceColorLut 'XrPassthroughColorLutMETA')
		(targetColorLut 'XrPassthroughColorLutMETA')
		(weight 'float')
	)
]
