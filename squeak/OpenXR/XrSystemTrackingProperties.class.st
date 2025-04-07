Class {
	#name : #XrSystemTrackingProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemTrackingProperties class >> fields [

	^ #(
		(orientationTracking 'XrBool32')
		(positionTracking 'XrBool32')
	)
]
