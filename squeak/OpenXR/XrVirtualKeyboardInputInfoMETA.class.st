Class {
	#name : #XrVirtualKeyboardInputInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrVirtualKeyboardInputInfoMETA class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(inputSource 'XrVirtualKeyboardInputSourceMETA')
		(inputSpace 'XrSpace')
		(inputPoseInSpace 'XrPosef')
		(inputState 'XrVirtualKeyboardInputStateFlagsMETA')
	)
]
