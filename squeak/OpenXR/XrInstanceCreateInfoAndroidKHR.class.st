Class {
	#name : #XrInstanceCreateInfoAndroidKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrInstanceCreateInfoAndroidKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(applicationVM 'void*')
		(applicationActivity 'void*')
	)
]
