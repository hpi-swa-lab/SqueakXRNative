Class {
	#name : #XrControllerModelNodeStateMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrControllerModelNodeStateMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(nodePose 'XrPosef')
	)
]
