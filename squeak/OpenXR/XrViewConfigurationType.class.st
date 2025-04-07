Class {
	#name : #XrViewConfigurationType,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{ #category : #'as yet unclassified' }
XrViewConfigurationType class >> XR_VIEW_CONFIGURATION_TYPE_PRIMARY_MONO [

	^ self on: (1)
]

{ #category : #'as yet unclassified' }
XrViewConfigurationType class >> XR_VIEW_CONFIGURATION_TYPE_PRIMARY_QUAD_VARJO [

	^ self on: (nil)
]

{ #category : #'as yet unclassified' }
XrViewConfigurationType class >> XR_VIEW_CONFIGURATION_TYPE_PRIMARY_STEREO [

	^ self on: (2)
]

{ #category : #'as yet unclassified' }
XrViewConfigurationType class >> XR_VIEW_CONFIGURATION_TYPE_SECONDARY_MONO_FIRST_PERSON_OBSERVER_MSFT [

	^ self on: (1000054000)
]

{ #category : #'as yet unclassified' }
XrViewConfigurationType class >> originalTypeName [

    ^ 'long'
]
