Class {
	#name : #XrSpaceLocation,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocation class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
	)
]
