Class {
	#name : #XrInteractionProfileAnalogThresholdVALVE,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrInteractionProfileAnalogThresholdVALVE class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(action 'XrAction')
		(binding 'XrPath')
		(onThreshold 'float')
		(offThreshold 'float')
		(onHaptic 'XrHapticBaseHeader*')
		(offHaptic 'XrHapticBaseHeader*')
	)
]
