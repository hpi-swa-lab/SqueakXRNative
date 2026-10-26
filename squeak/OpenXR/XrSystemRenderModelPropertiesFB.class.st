Class {
	#name : #XrSystemRenderModelPropertiesFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemRenderModelPropertiesFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(supportsRenderModelLoading 'XrBool32')
	)
]
