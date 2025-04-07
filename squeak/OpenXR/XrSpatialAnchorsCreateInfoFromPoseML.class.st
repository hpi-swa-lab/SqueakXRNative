Class {
	#name : #XrSpatialAnchorsCreateInfoFromPoseML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpatialAnchorsCreateInfoFromPoseML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(poseInBaseSpace 'XrPosef')
		(time 'XrTime')
	)
]
