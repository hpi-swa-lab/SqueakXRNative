Class {
	#name : #XrFrameEndInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFrameEndInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(displayTime 'XrTime')
		(environmentBlendMode 'XrEnvironmentBlendMode')
		(layerCount 'uint32_t')
		(layers 'XrCompositionLayerBaseHeader*')
	)
]
