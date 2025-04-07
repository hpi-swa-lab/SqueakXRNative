Class {
	#name : #XrInstanceCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{ #category : #'as yet unclassified' }
XrInstanceCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(createFlags 'XrInstanceCreateFlags')
		(applicationInfo 'XrApplicationInfo')
		(enabledApiLayerCount 'uint32_t')
		(enabledApiLayerNames 'char*')
		(enabledExtensionCount 'uint32_t')
		(enabledExtensionNames 'char*')
	)
]
