Class {
	#name : #XrHandTrackingAimStateFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrHandTrackingAimStateFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(status 'XrHandTrackingAimFlagsFB')
		(aimPose 'XrPosef')
		(pinchStrengthIndex 'float')
		(pinchStrengthMiddle 'float')
		(pinchStrengthRing 'float')
		(pinchStrengthLittle 'float')
	)
]
