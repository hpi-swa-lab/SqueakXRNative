Class {
	#name : #XrViewConfigurationViewFovEPIC,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrViewConfigurationViewFovEPIC class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(recommendedFov 'XrFovf')
		(maxMutableFov 'XrFovf')
	)
]
