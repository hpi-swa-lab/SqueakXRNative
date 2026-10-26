Class {
	#name : #XrNegotiateApiLayerRequest,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrNegotiateApiLayerRequest class >> fields [

	^ #(
		(structType 'XrLoaderInterfaceStructs')
		(structVersion 'uint32_t')
		(structSize 'size_t')
		(layerInterfaceVersion 'uint32_t')
		(layerApiVersion 'XrVersion')
		(getInstanceProcAddr 'PFN_xrGetInstanceProcAddr')
		(createApiLayerInstance 'PFN_xrCreateApiLayerInstance')
	)
]
