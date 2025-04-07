Class {
	#name : #XrBindingModificationsKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBindingModificationsKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(bindingModificationCount 'uint32_t')
		(bindingModifications 'XrBindingModificationBaseHeaderKHR*')
	)
]
