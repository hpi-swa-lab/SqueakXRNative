Class {
	#name : #XrKeyboardSpaceCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrKeyboardSpaceCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(trackedKeyboardId 'uint64_t')
	)
]
