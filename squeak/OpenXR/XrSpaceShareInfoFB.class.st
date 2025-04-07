Class {
	#name : #XrSpaceShareInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceShareInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
		(userCount 'uint32_t')
		(users 'XrSpaceUserFB*')
	)
]
