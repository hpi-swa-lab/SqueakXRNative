Class {
	#name : #XrSceneComponentsMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneComponentsMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(componentCapacityInput 'uint32_t')
		(componentCountOutput 'uint32_t')
		(components 'XrSceneComponentMSFT*')
	)
]
