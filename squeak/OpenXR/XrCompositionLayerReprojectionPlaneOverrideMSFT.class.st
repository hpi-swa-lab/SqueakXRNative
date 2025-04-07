Class {
	#name : #XrCompositionLayerReprojectionPlaneOverrideMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrCompositionLayerReprojectionPlaneOverrideMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(position 'XrVector3f')
		(normal 'XrVector3f')
		(velocity 'XrVector3f')
	)
]
