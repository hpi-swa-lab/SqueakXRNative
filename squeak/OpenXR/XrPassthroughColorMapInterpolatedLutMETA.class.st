Class {
	#name : #XrPassthroughColorMapInterpolatedLutMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrPassthroughColorMapInterpolatedLutMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sourceColorLut 'XrPassthroughColorLutMETA')
		(targetColorLut 'XrPassthroughColorLutMETA')
		(weight 'float')
	)
]
