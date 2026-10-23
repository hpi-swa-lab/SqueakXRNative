Class {
	#name : #XrHandTrackingScaleFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHandTrackingScaleFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(sensorOutput 'float')
		(currentOutput 'float')
		(overrideHandScale 'XrBool32')
		(overrideValueInput 'float')
	)
]
