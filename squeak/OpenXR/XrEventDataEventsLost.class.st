Class {
	#name : #XrEventDataEventsLost,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataEventsLost class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(lostEventCount 'uint32_t')
	)
]
