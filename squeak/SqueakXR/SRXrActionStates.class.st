Class {
	#name : #SRXrActionStates,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRXrActionStates class >> fields [

	" self defineFields "
	^ #(
		(gripPoses 'XrPosef[2]')
	)
]
