Class {
	#name : #XrHandTrackingDataSourceInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackingDataSourceInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestedDataSourceCount 'uint32_t')
		(requestedDataSources 'XrHandTrackingDataSourceEXT*')
	)
]
