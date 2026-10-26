Class {
	#name : #XrFaceTrackerCreateInfo2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFaceTrackerCreateInfo2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(faceExpressionSet 'XrFaceExpressionSet2FB')
		(requestedDataSourceCount 'uint32_t')
		(requestedDataSources 'XrFaceTrackingDataSource2FB*')
	)
]
