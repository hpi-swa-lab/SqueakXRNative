Class {
	#name : #XrSceneMarkerQRCodesMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSceneMarkerQRCodesMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(qrCodeCapacityInput 'uint32_t')
		(qrCodes 'XrSceneMarkerQRCodeMSFT*')
	)
]
