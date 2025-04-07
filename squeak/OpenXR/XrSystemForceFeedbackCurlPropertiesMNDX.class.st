Class {
	#name : #XrSystemForceFeedbackCurlPropertiesMNDX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemForceFeedbackCurlPropertiesMNDX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsForceFeedbackCurl 'XrBool32')
	)
]
