Class {
	#name : #XrSystemProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(systemId 'XrSystemId')
		(vendorId 'uint32_t')
		(systemName 'char[256]')
		(graphicsProperties 'XrSystemGraphicsProperties')
		(trackingProperties 'XrSystemTrackingProperties')
	)
]
