Class {
	#name : #XrBodyTrackerCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyTrackerCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bodyJointSet 'XrBodyJointSetFB')
	)
]
