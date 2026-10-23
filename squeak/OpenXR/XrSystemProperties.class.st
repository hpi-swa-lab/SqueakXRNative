Class {
	#name : #XrSystemProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
