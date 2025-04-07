Class {
	#name : #XrHandTrackingDataSourceStateEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackingDataSourceStateEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(dataSource 'XrHandTrackingDataSourceEXT')
	)
]
