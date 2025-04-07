Class {
	#name : #XrSpaceComponentFilterInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceComponentFilterInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(componentType 'XrSpaceComponentTypeFB')
	)
]
