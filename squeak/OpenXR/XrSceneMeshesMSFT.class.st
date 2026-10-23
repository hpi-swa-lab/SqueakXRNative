Class {
	#name : #XrSceneMeshesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneMeshesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sceneMeshCount 'uint32_t')
		(sceneMeshes 'XrSceneMeshMSFT*')
	)
]
