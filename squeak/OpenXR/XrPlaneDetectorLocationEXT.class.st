Class {
	#name : #XrPlaneDetectorLocationEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrPlaneDetectorLocationEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(planeId 'uint64_t')
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
		(extents 'XrExtent2Df')
		(orientation 'XrPlaneDetectorOrientationEXT')
		(semanticType 'XrPlaneDetectorSemanticTypeEXT')
		(polygonBufferCount 'uint32_t')
	)
]
