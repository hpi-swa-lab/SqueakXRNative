Class {
	#name : #XrSpacesLocateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSpacesLocateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(spaceCount 'uint32_t')
		(spaces 'XrSpace*')
	)
]
