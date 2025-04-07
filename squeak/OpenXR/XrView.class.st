Class {
	#name : #XrView,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrView class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(pose 'XrPosef')
		(fov 'XrFovf')
	)
]
