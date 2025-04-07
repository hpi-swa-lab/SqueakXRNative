Class {
	#name : #XrHandTrackerCreateInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackerCreateInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(hand 'XrHandEXT')
		(handJointSet 'XrHandJointSetEXT')
	)
]
