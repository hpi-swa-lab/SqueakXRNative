Class {
	#name : #XrFoveationApplyInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrFoveationApplyInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(mode 'XrFoveationModeHTC')
		(subImageCount 'uint32_t')
		(subImages 'XrSwapchainSubImage*')
	)
]
