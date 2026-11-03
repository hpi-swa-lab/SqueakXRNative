Class {
	#name : #XrVirtualKeyboardInputInfoMETA,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
