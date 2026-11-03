Class {
	#name : #XrViewLocateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrViewLocateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(viewConfigurationType 'XrViewConfigurationType')
		(displayTime 'XrTime')
		(space 'XrSpace')
	)
]
