Class {
	#name : #XrInstanceCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
