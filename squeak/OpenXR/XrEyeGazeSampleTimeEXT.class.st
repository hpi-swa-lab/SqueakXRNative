Class {
	#name : #XrEyeGazeSampleTimeEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrEyeGazeSampleTimeEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(time 'XrTime')
	)
]
