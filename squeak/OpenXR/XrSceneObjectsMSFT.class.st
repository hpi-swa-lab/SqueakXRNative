Class {
	#name : #XrSceneObjectsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneObjectsMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneObjectCount 'uint32_t')
		(sceneObjects 'XrSceneObjectMSFT*')
	)
]
