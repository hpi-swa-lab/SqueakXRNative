Class {
	#name : #XrInputSourceLocalizedNameFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrInputSourceLocalizedNameFlagBits class >> XR_INPUT_SOURCE_LOCALIZED_NAME_COMPONENT_BIT [

	^ self on: (1 bitShift: 2)
]

{ #category : #'as yet unclassified' }
XrInputSourceLocalizedNameFlagBits class >> XR_INPUT_SOURCE_LOCALIZED_NAME_INTERACTION_PROFILE_BIT [

	^ self on: (1 bitShift: 1)
]

{ #category : #'as yet unclassified' }
XrInputSourceLocalizedNameFlagBits class >> XR_INPUT_SOURCE_LOCALIZED_NAME_USER_PATH_BIT [

	^ self on: (1 bitShift: 0)
]

{ #category : #'as yet unclassified' }
XrInputSourceLocalizedNameFlagBits class >> originalTypeName [

    ^ 'long'
]
