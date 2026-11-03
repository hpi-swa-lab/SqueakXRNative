Class {
	#name : #XrSpatialAnchorCreateInfoHTC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpatialAnchorCreateInfoHTC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(space 'XrSpace')
		(poseInSpace 'XrPosef')
		(name 'XrSpatialAnchorNameHTC')
	)
]
