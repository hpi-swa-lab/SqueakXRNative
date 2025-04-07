Class {
	#name : #XrBodyJointLocationsHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyJointLocationsHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(combinedLocationFlags 'XrSpaceLocationFlags')
		(confidenceLevel 'XrBodyJointConfidenceHTC')
		(jointLocationCount 'uint32_t')
		(jointLocations 'XrBodyJointLocationHTC*')
		(skeletonGenerationId 'uint32_t')
	)
]
