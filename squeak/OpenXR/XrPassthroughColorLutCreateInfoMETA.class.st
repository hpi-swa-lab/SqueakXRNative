Class {
	#name : #XrPassthroughColorLutCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrPassthroughColorLutCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(channels 'XrPassthroughColorLutChannelsMETA')
		(resolution 'uint32_t')
		(data 'XrPassthroughColorLutDataMETA')
	)
]
