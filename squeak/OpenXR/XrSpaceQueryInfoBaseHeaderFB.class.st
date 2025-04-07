Class {
	#name : #XrSpaceQueryInfoBaseHeaderFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceQueryInfoBaseHeaderFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
	)
]
