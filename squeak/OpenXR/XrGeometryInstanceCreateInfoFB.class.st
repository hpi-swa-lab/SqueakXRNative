Class {
	#name : #XrGeometryInstanceCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
