Class {
	#name : #XrSpaceVelocity,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceVelocity class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(velocityFlags 'XrSpaceVelocityFlags')
		(linearVelocity 'XrVector3f')
		(angularVelocity 'XrVector3f')
	)
]
