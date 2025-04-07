Class {
	#name : #XrAndroidSurfaceSwapchainCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrAndroidSurfaceSwapchainCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrAndroidSurfaceSwapchainFlagsFB')
	)
]
