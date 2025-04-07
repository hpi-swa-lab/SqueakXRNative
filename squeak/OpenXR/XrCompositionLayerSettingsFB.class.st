Class {
	#name : #XrCompositionLayerSettingsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layerFlags 'XrCompositionLayerSettingsFlagsFB')
	)
]
