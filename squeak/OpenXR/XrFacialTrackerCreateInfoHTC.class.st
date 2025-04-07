Class {
	#name : #XrFacialTrackerCreateInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFacialTrackerCreateInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(facialTrackingType 'XrFacialTrackingTypeHTC')
	)
]
