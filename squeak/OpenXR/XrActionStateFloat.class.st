Class {
	#name : #XrActionStateFloat,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionStateFloat class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(currentState 'float')
		(changedSinceLastSync 'XrBool32')
		(lastChangeTime 'XrTime')
		(isActive 'XrBool32')
	)
]
