Class {
	#name : #XrSessionBeginInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSessionBeginInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(primaryViewConfigurationType 'XrViewConfigurationType')
	)
]
