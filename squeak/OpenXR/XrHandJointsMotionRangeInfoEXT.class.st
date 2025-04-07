Class {
	#name : #XrHandJointsMotionRangeInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandJointsMotionRangeInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(handJointsMotionRange 'XrHandJointsMotionRangeEXT')
	)
]
