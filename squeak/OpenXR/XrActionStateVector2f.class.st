Class {
	#name : #XrActionStateVector2f,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrActionStateVector2f class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(currentState 'XrVector2f')
		(changedSinceLastSync 'XrBool32')
		(lastChangeTime 'XrTime')
		(isActive 'XrBool32')
	)
]
