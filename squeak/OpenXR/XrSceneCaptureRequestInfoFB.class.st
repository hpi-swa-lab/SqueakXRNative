Class {
	#name : #XrSceneCaptureRequestInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneCaptureRequestInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestByteCount 'uint32_t')
		(request 'char*')
	)
]
