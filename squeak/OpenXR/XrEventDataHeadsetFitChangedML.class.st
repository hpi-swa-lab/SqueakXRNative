Class {
	#name : #XrEventDataHeadsetFitChangedML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-5-Generated'
}

{ #category : #'as yet unclassified' }
XrEventDataHeadsetFitChangedML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(status 'XrHeadsetFitStatusML')
		(time 'XrTime')
	)
]
