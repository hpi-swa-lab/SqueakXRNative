Class {
	#name : #XrHandJointLocationsEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrHandJointLocationsEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(jointCount 'uint32_t')
		(jointLocations 'XrHandJointLocationEXT*')
	)
]
