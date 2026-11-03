Class {
	#name : #XrHandCapsuleFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHandCapsuleFB class >> fields [

	^ #(
		(points 'XrVector3f[2]')
		(radius 'float')
		(joint 'XrHandJointEXT')
	)
]
