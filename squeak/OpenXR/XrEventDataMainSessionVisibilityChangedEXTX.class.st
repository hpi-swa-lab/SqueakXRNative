Class {
	#name : #XrEventDataMainSessionVisibilityChangedEXTX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataMainSessionVisibilityChangedEXTX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(visible 'XrBool32')
		(flags 'XrOverlayMainSessionFlagsEXTX')
	)
]
