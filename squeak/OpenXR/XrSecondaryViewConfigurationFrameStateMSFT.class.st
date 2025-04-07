Class {
	#name : #XrSecondaryViewConfigurationFrameStateMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSecondaryViewConfigurationFrameStateMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationCount 'uint32_t')
		(viewConfigurationStates 'XrSecondaryViewConfigurationStateMSFT*')
	)
]
