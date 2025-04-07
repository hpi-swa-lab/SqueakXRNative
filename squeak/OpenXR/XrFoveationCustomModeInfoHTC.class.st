Class {
	#name : #XrFoveationCustomModeInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationCustomModeInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(configCount 'uint32_t')
		(configs 'XrFoveationConfigurationHTC*')
	)
]
