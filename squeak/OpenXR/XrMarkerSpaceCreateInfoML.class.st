Class {
	#name : #XrMarkerSpaceCreateInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerSpaceCreateInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerDetector 'XrMarkerDetectorML')
		(marker 'XrMarkerML')
		(poseInMarkerSpace 'XrPosef')
	)
]
