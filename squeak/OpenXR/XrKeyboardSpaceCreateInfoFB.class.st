Class {
	#name : #XrKeyboardSpaceCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrKeyboardSpaceCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(trackedKeyboardId 'uint64_t')
	)
]
