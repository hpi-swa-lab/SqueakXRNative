Class {
	#name : #XrVirtualKeyboardLocationInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardLocationInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationType 'XrVirtualKeyboardLocationTypeMETA')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
		(scale 'float')
	)
]
