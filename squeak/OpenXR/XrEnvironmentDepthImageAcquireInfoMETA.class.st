Class {
	#name : #XrEnvironmentDepthImageAcquireInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEnvironmentDepthImageAcquireInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(displayTime 'XrTime')
	)
]
