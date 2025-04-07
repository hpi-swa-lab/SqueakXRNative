Class {
	#name : #XrLoaderInitInfoAndroidKHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrLoaderInitInfoAndroidKHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(applicationVM 'void*')
		(applicationContext 'void*')
	)
]
