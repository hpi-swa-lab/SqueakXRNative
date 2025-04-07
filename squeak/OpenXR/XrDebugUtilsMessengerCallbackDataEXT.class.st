Class {
	#name : #XrDebugUtilsMessengerCallbackDataEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
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
