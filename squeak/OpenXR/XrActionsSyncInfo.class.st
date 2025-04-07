Class {
	#name : #XrActionsSyncInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionsSyncInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(countActiveActionSets 'uint32_t')
		(activeActionSets 'XrActiveActionSet*')
	)
]
