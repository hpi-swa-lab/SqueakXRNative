Class {
	#name : #XrPassthroughColorLutDataMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrPassthroughColorLutDataMETA class >> fields [

	^ #(
		(bufferSize 'uint32_t')
		(buffer 'uint8_t*')
	)
]
