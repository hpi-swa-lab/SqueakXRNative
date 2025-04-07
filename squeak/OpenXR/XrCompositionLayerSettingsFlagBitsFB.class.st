Class {
	#name : #XrCompositionLayerSettingsFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> XR_COMPOSITION_LAYER_SETTINGS_AUTO_LAYER_FILTER_BIT_META [

	^ self on: (nil)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> XR_COMPOSITION_LAYER_SETTINGS_NORMAL_SHARPENING_BIT_FB [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> XR_COMPOSITION_LAYER_SETTINGS_NORMAL_SUPER_SAMPLING_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> XR_COMPOSITION_LAYER_SETTINGS_QUALITY_SHARPENING_BIT_FB [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> XR_COMPOSITION_LAYER_SETTINGS_QUALITY_SUPER_SAMPLING_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrCompositionLayerSettingsFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
