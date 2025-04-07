Class {
	#name : #XrExtensionProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrExtensionProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(extensionName 'char[128]')
		(extensionVersion 'uint32_t')
	)
]
