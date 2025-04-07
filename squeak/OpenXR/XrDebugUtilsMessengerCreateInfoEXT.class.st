Class {
	#name : #XrDebugUtilsMessengerCreateInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrDebugUtilsMessengerCreateInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(messageSeverities 'XrDebugUtilsMessageSeverityFlagsEXT')
		(messageTypes 'XrDebugUtilsMessageTypeFlagsEXT')
		(userCallback 'PFN_xrDebugUtilsMessengerCallbackEXT')
		(userData 'void*')
	)
]
