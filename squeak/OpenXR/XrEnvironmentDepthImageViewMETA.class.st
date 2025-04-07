Class {
	#name : #XrEnvironmentDepthImageViewMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEnvironmentDepthImageViewMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fov 'XrFovf')
		(pose 'XrPosef')
	)
]
