Class {
	#name : #XrFoveationDynamicModeInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationDynamicModeInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(dynamicFlags 'XrFoveationDynamicFlagsHTC')
	)
]
