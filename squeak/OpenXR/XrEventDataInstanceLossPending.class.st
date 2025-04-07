Class {
	#name : #XrEventDataInstanceLossPending,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataInstanceLossPending class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(lossTime 'XrTime')
	)
]
