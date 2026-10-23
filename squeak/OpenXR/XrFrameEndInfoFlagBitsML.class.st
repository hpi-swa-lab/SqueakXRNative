Class {
	#name : #XrFrameEndInfoFlagBitsML,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFrameEndInfoFlagBitsML class >> XR_FRAME_END_INFO_PROTECTED_BIT_ML [

	^ self on: (1 bitShift: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFrameEndInfoFlagBitsML class >> XR_FRAME_END_INFO_VIGNETTE_BIT_ML [

	^ self on: (1 bitShift: 1)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFrameEndInfoFlagBitsML class >> originalTypeName [

    ^ 'long'
]
