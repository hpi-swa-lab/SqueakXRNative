Class {
	#name : #XrActionSpaceCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrActionSpaceCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(action 'XrAction')
		(subactionPath 'XrPath')
		(poseInActionSpace 'XrPosef')
	)
]
