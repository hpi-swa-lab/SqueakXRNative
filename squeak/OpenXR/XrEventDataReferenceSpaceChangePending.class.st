Class {
	#name : #XrEventDataReferenceSpaceChangePending,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataReferenceSpaceChangePending class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(referenceSpaceType 'XrReferenceSpaceType')
		(changeTime 'XrTime')
		(poseValid 'XrBool32')
		(poseInPreviousSpace 'XrPosef')
	)
]
