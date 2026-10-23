Class {
	#name : #XrSwapchainCreateFoveationFlagBitsFB,
	#superclass : #ExternalTypeAlias,
	#category : #'OpenXR-Typedefs-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainCreateFoveationFlagBitsFB class >> XR_SWAPCHAIN_CREATE_FOVEATION_FRAGMENT_DENSITY_MAP_BIT_FB [

	^ self on: (1 bitShift: 1)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainCreateFoveationFlagBitsFB class >> XR_SWAPCHAIN_CREATE_FOVEATION_SCALED_BIN_BIT_FB [

	^ self on: (1 bitShift: 0)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSwapchainCreateFoveationFlagBitsFB class >> originalTypeName [

    ^ 'long'
]
