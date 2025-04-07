Class {
	#name : #XrFrameEndInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameEndInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(focusDistance 'float')
		(flags 'XrFrameEndInfoFlagsML')
	)
]
