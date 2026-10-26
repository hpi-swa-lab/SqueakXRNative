Class {
	#name : #XrEventDataMainSessionVisibilityChangedEXTX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataMainSessionVisibilityChangedEXTX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(visible 'XrBool32')
		(flags 'XrOverlayMainSessionFlagsEXTX')
	)
]
