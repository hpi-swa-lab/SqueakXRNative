Class {
	#name : #XrGraphicsBindingMetalKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrGraphicsBindingMetalKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(commandQueue 'void*')
	)
]
