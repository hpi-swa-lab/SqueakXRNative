Class {
	#name : #SRXrActionStates,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRXrActionStates class >> fields [

	" self defineFields "
	^ #(
		(aimPoses 'XrPosef[2]')
		(triggers 'float[2]')
	)
]
