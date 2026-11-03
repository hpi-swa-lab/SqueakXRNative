Class {
	#name : #XrSystemTrackingProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSystemTrackingProperties class >> fields [

	^ #(
		(orientationTracking 'XrBool32')
		(positionTracking 'XrBool32')
	)
]
