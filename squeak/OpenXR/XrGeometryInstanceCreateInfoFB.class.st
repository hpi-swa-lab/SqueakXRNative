Class {
	#name : #XrGeometryInstanceCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrGeometryInstanceCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(layer 'XrPassthroughLayerFB')
		(mesh 'XrTriangleMeshFB')
		(baseSpace 'XrSpace')
		(pose 'XrPosef')
		(scale 'XrVector3f')
	)
]
