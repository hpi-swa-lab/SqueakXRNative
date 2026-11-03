Class {
	#name : #XrEventDataViveTrackerConnectedHTCX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataViveTrackerConnectedHTCX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(paths 'XrViveTrackerPathsHTCX*')
	)
]
