Class {
	#name : #XrDebugUtilsMessengerCallbackDataEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrDebugUtilsMessengerCallbackDataEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(messageId 'char*')
		(functionName 'char*')
		(message 'char*')
		(objectCount 'uint32_t')
		(objects 'XrDebugUtilsObjectNameInfoEXT*')
		(sessionLabelCount 'uint32_t')
		(sessionLabels 'XrDebugUtilsLabelEXT*')
	)
]
