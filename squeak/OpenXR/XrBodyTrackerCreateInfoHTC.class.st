Class {
	#name : #XrBodyTrackerCreateInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyTrackerCreateInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bodyJointSet 'XrBodyJointSetHTC')
	)
]
