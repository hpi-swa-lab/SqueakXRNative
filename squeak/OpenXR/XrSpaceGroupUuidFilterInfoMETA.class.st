Class {
	#name : #XrSpaceGroupUuidFilterInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceGroupUuidFilterInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(groupUuid 'XrUuid')
	)
]
