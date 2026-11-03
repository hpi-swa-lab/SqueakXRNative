Class {
	#name : #XrFaceExpressionInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFaceExpressionInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(time 'XrTime')
	)
]
