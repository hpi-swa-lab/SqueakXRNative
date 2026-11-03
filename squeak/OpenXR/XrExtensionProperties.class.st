Class {
	#name : #XrExtensionProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrExtensionProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(extensionName 'char[128]')
		(extensionVersion 'uint32_t')
	)
]
