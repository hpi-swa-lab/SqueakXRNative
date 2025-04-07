Class {
	#name : #XrForceFeedbackCurlApplyLocationsMNDX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrForceFeedbackCurlApplyLocationsMNDX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationCount 'uint32_t')
		(locations 'XrForceFeedbackCurlApplyLocationMNDX*')
	)
]
