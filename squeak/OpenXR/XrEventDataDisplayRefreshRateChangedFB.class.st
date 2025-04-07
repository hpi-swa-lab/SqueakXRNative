Class {
	#name : #XrEventDataDisplayRefreshRateChangedFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataDisplayRefreshRateChangedFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fromDisplayRefreshRate 'float')
		(toDisplayRefreshRate 'float')
	)
]
