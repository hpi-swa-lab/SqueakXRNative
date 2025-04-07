Class {
	#name : #XrGeometryInstanceTransformFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrGeometryInstanceTransformFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(time 'XrTime')
		(pose 'XrPosef')
		(scale 'XrVector3f')
	)
]
