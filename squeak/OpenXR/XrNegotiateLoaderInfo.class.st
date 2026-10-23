Class {
	#name : #XrNegotiateLoaderInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrNegotiateLoaderInfo class >> fields [

	^ #(
		(structType 'XrLoaderInterfaceStructs')
		(structVersion 'uint32_t')
		(structSize 'size_t')
		(minInterfaceVersion 'uint32_t')
		(maxInterfaceVersion 'uint32_t')
		(minApiVersion 'XrVersion')
		(maxApiVersion 'XrVersion')
	)
]
