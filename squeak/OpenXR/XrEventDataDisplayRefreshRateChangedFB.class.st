Class {
	#name : #XrEventDataDisplayRefreshRateChangedFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataDisplayRefreshRateChangedFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fromDisplayRefreshRate 'float')
		(toDisplayRefreshRate 'float')
	)
]
