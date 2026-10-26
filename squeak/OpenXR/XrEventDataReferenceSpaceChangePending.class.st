Class {
	#name : #XrEventDataReferenceSpaceChangePending,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
