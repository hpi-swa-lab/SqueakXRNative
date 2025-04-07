Class {
	#name : #XrLocalDimmingFrameEndInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrLocalDimmingFrameEndInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(localDimmingMode 'XrLocalDimmingModeMETA')
	)
]
