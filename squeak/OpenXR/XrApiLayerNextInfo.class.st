Class {
	#name : #XrApiLayerNextInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrApiLayerNextInfo class >> fields [

	^ #(
		(structType 'XrLoaderInterfaceStructs')
		(structVersion 'uint32_t')
		(structSize 'size_t')
		(layerName 'char[256]')
		(nextGetInstanceProcAddr 'PFN_xrGetInstanceProcAddr')
		(nextCreateApiLayerInstance 'PFN_xrCreateApiLayerInstance')
		(next 'XrApiLayerNextInfo*')
	)
]
