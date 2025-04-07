Class {
	#name : #XrDebugUtilsObjectNameInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrDebugUtilsObjectNameInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(objectType 'XrObjectType')
		(objectHandle 'uint64_t')
		(objectName 'char*')
	)
]
