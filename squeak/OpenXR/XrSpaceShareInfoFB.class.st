Class {
	#name : #XrSpaceShareInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
