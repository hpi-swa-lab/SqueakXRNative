Class {
	#name : #XrScenePlanesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrScenePlanesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(scenePlaneCount 'uint32_t')
		(scenePlanes 'XrScenePlaneMSFT*')
	)
]
