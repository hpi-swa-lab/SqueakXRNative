Class {
	#name : #XrSessionBeginInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSessionBeginInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(primaryViewConfigurationType 'XrViewConfigurationType')
	)
]
