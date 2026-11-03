Class {
	#name : #XrExtent2Di,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrExtent2Di class >> fields [

	^ #(
		(width 'int32_t')
		(height 'int32_t')
	)
]
