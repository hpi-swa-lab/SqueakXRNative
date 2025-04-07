Class {
	#name : #XrReferenceSpaceCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrReferenceSpaceCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(referenceSpaceType 'XrReferenceSpaceType')
		(poseInReferenceSpace 'XrPosef')
	)
]
