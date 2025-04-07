Class {
	#name : #XrFrustumf,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrFrustumf class >> fields [

	^ #(
		(pose 'XrPosef')
		(fov 'XrFovf')
		(nearZ 'float')
		(farZ 'float')
	)
]
