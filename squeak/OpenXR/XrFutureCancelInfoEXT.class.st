Class {
	#name : #XrFutureCancelInfoEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrFutureCancelInfoEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(future 'XrFutureEXT')
	)
]
