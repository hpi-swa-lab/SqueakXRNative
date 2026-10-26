Class {
	#name : #XrSpatialAnchorsQueryInfoRadiusML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorsQueryInfoRadiusML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(baseSpace 'XrSpace')
		(center 'XrVector3f')
		(time 'XrTime')
		(radius 'float')
	)
]
