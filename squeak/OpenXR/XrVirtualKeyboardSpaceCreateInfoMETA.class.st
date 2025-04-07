Class {
	#name : #XrVirtualKeyboardSpaceCreateInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardSpaceCreateInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationType 'XrVirtualKeyboardLocationTypeMETA')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
	)
]
