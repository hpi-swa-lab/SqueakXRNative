Class {
	#name : #XrSpaceQueryResultFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceQueryResultFB class >> fields [

	^ #(
		(space 'XrSpace')
		(uuid 'XrUuidEXT')
	)
]
