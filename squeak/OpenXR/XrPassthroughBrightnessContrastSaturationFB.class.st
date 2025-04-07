Class {
	#name : #XrPassthroughBrightnessContrastSaturationFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrPassthroughBrightnessContrastSaturationFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(brightness 'float')
		(contrast 'float')
		(saturation 'float')
	)
]
