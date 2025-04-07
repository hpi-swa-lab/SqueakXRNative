Class {
	#name : #XrViveTrackerPathsHTCX,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrViveTrackerPathsHTCX class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(persistentPath 'XrPath')
		(rolePath 'XrPath')
	)
]
