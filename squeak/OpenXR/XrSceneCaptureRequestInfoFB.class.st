Class {
	#name : #XrSceneCaptureRequestInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneCaptureRequestInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestByteCount 'uint32_t')
		(request 'char*')
	)
]
