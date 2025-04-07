Class {
	#name : #XrApiLayerNextInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
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
