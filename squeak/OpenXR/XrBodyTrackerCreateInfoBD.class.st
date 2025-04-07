Class {
	#name : #XrBodyTrackerCreateInfoBD,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyTrackerCreateInfoBD class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(jointSet 'XrBodyJointSetBD')
	)
]
