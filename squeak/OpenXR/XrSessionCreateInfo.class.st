Class {
	#name : #XrSessionCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSessionCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrSessionCreateFlags')
		(systemId 'XrSystemId')
	)
]
