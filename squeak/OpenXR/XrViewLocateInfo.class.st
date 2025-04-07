Class {
	#name : #XrViewLocateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrViewLocateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationType 'XrViewConfigurationType')
		(displayTime 'XrTime')
		(space 'XrSpace')
	)
]
