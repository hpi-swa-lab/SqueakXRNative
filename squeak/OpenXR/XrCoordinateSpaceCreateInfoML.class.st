Class {
	#name : #XrCoordinateSpaceCreateInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCoordinateSpaceCreateInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(cfuid 'void')
		(poseInCoordinateSpace 'XrPosef')
	)
]
