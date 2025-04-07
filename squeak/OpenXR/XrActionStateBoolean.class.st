Class {
	#name : #XrActionStateBoolean,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionStateBoolean class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(currentState 'XrBool32')
		(changedSinceLastSync 'XrBool32')
		(lastChangeTime 'XrTime')
		(isActive 'XrBool32')
	)
]
