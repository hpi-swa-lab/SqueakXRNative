Class {
	#name : #XrFrameState,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrFrameState class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(predictedDisplayTime 'XrTime')
		(predictedDisplayPeriod 'XrDuration')
		(shouldRender 'XrBool32')
	)
]
