Class {
	#name : #XrEventDataVisibilityMaskChangedKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataVisibilityMaskChangedKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(viewConfigurationType 'XrViewConfigurationType')
		(viewIndex 'uint32_t')
	)
]
