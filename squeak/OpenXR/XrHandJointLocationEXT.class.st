Class {
	#name : #XrHandJointLocationEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHandJointLocationEXT class >> fields [

	^ #(
		(locationFlags 'XrSpaceLocationFlags')
		(pose 'XrPosef')
		(radius 'float')
	)
]
