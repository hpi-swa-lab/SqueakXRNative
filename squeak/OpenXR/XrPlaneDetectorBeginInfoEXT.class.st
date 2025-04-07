Class {
	#name : #XrPlaneDetectorBeginInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectorBeginInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(orientationCount 'uint32_t')
		(orientations 'XrPlaneDetectorOrientationEXT*')
		(semanticTypeCount 'uint32_t')
		(semanticTypes 'XrPlaneDetectorSemanticTypeEXT*')
		(maxPlanes 'uint32_t')
		(minArea 'float')
		(boundingBoxPose 'XrPosef')
		(boundingBoxExtent 'XrExtent3DfEXT')
	)
]
