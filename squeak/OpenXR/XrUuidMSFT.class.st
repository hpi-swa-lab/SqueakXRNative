Class {
	#name : #XrUuidMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrUuidMSFT class >> fields [

	^ #(
		(bytes 'uint8_t[16]')
	)
]
