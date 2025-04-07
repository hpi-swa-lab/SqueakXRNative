Class {
	#name : #XrSceneMeshesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMeshesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneMeshCount 'uint32_t')
		(sceneMeshes 'XrSceneMeshMSFT*')
	)
]
