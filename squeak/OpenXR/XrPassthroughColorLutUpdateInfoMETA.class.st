Class {
	#name : #XrPassthroughColorLutUpdateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughColorLutUpdateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(data 'XrPassthroughColorLutDataMETA')
	)
]
