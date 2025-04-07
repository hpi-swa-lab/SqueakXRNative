Class {
	#name : #XrSessionCreateInfoOverlayEXTX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrSessionCreateInfoOverlayEXTX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrOverlaySessionCreateFlagsEXTX')
		(sessionLayersPlacement 'uint32_t')
	)
]
