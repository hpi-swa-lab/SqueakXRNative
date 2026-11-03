Class {
	#name : #XrSceneMarkerQRCodesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneMarkerQRCodesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(qrCodeCapacityInput 'uint32_t')
		(qrCodes 'XrSceneMarkerQRCodeMSFT*')
	)
]
