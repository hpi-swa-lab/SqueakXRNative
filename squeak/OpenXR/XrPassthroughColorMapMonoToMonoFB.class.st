Class {
	#name : #XrPassthroughColorMapMonoToMonoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrPassthroughColorMapMonoToMonoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(textureColorMap 'uint8_t[256]')
	)
]
