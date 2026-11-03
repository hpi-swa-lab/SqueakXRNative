Class {
	#name : #XrScenePlanesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrScenePlanesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(scenePlaneCount 'uint32_t')
		(scenePlanes 'XrScenePlaneMSFT*')
	)
]
