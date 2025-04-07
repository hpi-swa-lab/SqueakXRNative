Class {
	#name : #XrGlobalDimmerFrameEndInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrGlobalDimmerFrameEndInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(dimmerValue 'float')
		(flags 'XrGlobalDimmerFrameEndInfoFlagsML')
	)
]
