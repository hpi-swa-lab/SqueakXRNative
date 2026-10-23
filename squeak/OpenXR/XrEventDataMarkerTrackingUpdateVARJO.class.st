Class {
	#name : #XrEventDataMarkerTrackingUpdateVARJO,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataMarkerTrackingUpdateVARJO class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(markerId 'uint64_t')
		(isActive 'XrBool32')
		(isPredicted 'XrBool32')
		(time 'XrTime')
	)
]
