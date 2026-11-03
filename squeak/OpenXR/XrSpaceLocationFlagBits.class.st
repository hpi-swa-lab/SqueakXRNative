Class {
	#name : #XrSpaceLocationFlagBits,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocationFlagBits class >> XR_SPACE_LOCATION_ORIENTATION_TRACKED_BIT [

	^ self on: (1 bitShift: 2)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocationFlagBits class >> XR_SPACE_LOCATION_ORIENTATION_VALID_BIT [

	^ self on: (1 bitShift: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocationFlagBits class >> XR_SPACE_LOCATION_POSITION_TRACKED_BIT [

	^ self on: (1 bitShift: 3)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocationFlagBits class >> XR_SPACE_LOCATION_POSITION_VALID_BIT [

	^ self on: (1 bitShift: 1)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceLocationFlagBits class >> originalTypeName [

    ^ 'long'
]
