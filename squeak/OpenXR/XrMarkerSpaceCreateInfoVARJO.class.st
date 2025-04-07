Class {
	#name : #XrMarkerSpaceCreateInfoVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrMarkerSpaceCreateInfoVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerId 'uint64_t')
		(poseInMarkerSpace 'XrPosef')
	)
]
