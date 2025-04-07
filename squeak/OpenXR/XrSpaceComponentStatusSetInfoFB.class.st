Class {
	#name : #XrSpaceComponentStatusSetInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceComponentStatusSetInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(componentType 'XrSpaceComponentTypeFB')
		(enabled 'XrBool32')
		(timeout 'XrDuration')
	)
]
