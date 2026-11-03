Class {
	#name : #XrHandTrackingAimStateFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
