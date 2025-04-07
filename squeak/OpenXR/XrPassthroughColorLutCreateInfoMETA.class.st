Class {
	#name : #XrPassthroughColorLutCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorLutCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(channels 'XrPassthroughColorLutChannelsMETA')
		(resolution 'uint32_t')
		(data 'XrPassthroughColorLutDataMETA')
	)
]
