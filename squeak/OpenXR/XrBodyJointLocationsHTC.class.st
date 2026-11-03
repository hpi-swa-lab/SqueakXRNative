Class {
	#name : #XrBodyJointLocationsHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
