Class {
	#name : #XrHandTrackingScaleFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
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
