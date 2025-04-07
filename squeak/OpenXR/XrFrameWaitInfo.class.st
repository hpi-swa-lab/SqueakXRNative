Class {
	#name : #XrFrameWaitInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameWaitInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
