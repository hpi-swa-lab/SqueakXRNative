Class {
	#name : #XrInputSourceLocalizedNameGetInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrInputSourceLocalizedNameGetInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sourcePath 'XrPath')
		(whichComponents 'XrInputSourceLocalizedNameFlags')
	)
]
