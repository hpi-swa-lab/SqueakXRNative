Class {
	#name : #XrSecondaryViewConfigurationSessionBeginInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSecondaryViewConfigurationSessionBeginInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationCount 'uint32_t')
		(enabledViewConfigurationTypes 'XrViewConfigurationType*')
	)
]
