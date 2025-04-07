Class {
	#name : #XrBodyJointLocationsBD,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyJointLocationsBD class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(allJointPosesTracked 'XrBool32')
		(jointLocationCount 'uint32_t')
		(jointLocations 'XrBodyJointLocationBD*')
	)
]
