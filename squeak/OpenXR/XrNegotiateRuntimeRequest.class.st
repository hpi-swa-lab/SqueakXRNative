Class {
	#name : #XrNegotiateRuntimeRequest,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrNegotiateRuntimeRequest class >> fields [

	^ #(
		(structType 'XrLoaderInterfaceStructs')
		(structVersion 'uint32_t')
		(structSize 'size_t')
		(runtimeInterfaceVersion 'uint32_t')
		(runtimeApiVersion 'XrVersion')
		(getInstanceProcAddr 'PFN_xrGetInstanceProcAddr')
	)
]
