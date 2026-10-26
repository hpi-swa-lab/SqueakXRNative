Class {
	#name : #XrEventDataVisibilityMaskChangedKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataVisibilityMaskChangedKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(session 'XrSession')
		(viewConfigurationType 'XrViewConfigurationType')
		(viewIndex 'uint32_t')
	)
]
