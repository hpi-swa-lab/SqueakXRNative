Class {
	#name : #XrInstanceProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrInstanceProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(runtimeVersion 'XrVersion')
		(runtimeName 'char[128]')
	)
]
