Class {
	#name : #XrApplicationInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrApplicationInfo class >> fields [

	^ #(
		(applicationName 'char[128]')
		(applicationVersion 'uint32_t')
		(engineName 'char[128]')
		(engineVersion 'uint32_t')
		(apiVersion 'XrVersion')
	)
]
