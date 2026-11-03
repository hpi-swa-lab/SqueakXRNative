Class {
	#name : #XrEventDataSpaceSetStatusCompleteFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrEventDataSpaceSetStatusCompleteFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(requestId 'XrAsyncRequestIdFB')
		(result 'XrResult')
		(space 'XrSpace')
		(uuid 'XrUuidEXT')
		(componentType 'XrSpaceComponentTypeFB')
		(enabled 'XrBool32')
	)
]
