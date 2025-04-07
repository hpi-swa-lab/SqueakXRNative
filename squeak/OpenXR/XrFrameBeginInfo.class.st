Class {
	#name : #XrFrameBeginInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameBeginInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
