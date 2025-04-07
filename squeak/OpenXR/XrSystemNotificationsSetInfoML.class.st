Class {
	#name : #XrSystemNotificationsSetInfoML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrSystemNotificationsSetInfoML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(suppressNotifications 'XrBool32')
	)
]
