Class {
	#name : #XrDebugUtilsMessengerCreateInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
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
