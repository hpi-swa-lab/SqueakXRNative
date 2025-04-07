Class {
	#name : #XrSpaceUserCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpaceUserCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(userId 'XrSpaceUserIdFB')
	)
]
