Class {
	#name : #XrFaceTrackerCreateInfo2FB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrFaceTrackerCreateInfo2FB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(faceExpressionSet 'XrFaceExpressionSet2FB')
		(requestedDataSourceCount 'uint32_t')
		(requestedDataSources 'XrFaceTrackingDataSource2FB*')
	)
]
