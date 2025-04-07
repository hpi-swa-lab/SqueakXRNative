Class {
	#name : #XrLocalizationMapErrorFlagBitsML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_EXCESSIVE_MOTION_BIT_ML [

	^ self on: (1 bitShift: 3)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_HEADPOSE_BIT_ML [

	^ self on: (1 bitShift: 5)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_LOW_FEATURE_COUNT_BIT_ML [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_LOW_LIGHT_BIT_ML [

	^ self on: (1 bitShift: 4)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_OUT_OF_MAPPED_AREA_BIT_ML [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> XR_LOCALIZATION_MAP_ERROR_UNKNOWN_BIT_ML [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrLocalizationMapErrorFlagBitsML class >> originalTypeName [

    ^ 'long'
]
