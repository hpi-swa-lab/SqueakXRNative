Class {
	#name : #XrFoveationLevelProfileCreateInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrFoveationLevelProfileCreateInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(level 'XrFoveationLevelFB')
		(verticalOffset 'float')
		(dynamic 'XrFoveationDynamicFB')
	)
]
