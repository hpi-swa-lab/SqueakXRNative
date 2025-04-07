Class {
	#name : #XrFuturePollResultEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrFuturePollResultEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(state 'XrFutureStateEXT')
	)
]
