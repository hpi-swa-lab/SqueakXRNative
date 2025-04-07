Class {
	#name : #XrEventDataViveTrackerConnectedHTCX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataViveTrackerConnectedHTCX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(paths 'XrViveTrackerPathsHTCX*')
	)
]
