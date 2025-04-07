Class {
	#name : #XrEnvironmentDepthImageAcquireInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthImageAcquireInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(displayTime 'XrTime')
	)
]
