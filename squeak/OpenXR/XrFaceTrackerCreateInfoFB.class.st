Class {
	#name : #XrFaceTrackerCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFaceTrackerCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(faceExpressionSet 'XrFaceExpressionSetFB')
	)
]
