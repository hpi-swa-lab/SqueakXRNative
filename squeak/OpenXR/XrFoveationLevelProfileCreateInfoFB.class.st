Class {
	#name : #XrFoveationLevelProfileCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationLevelProfileCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(level 'XrFoveationLevelFB')
		(verticalOffset 'float')
		(dynamic 'XrFoveationDynamicFB')
	)
]
