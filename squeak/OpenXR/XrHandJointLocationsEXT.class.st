Class {
	#name : #XrHandJointLocationsEXT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrHandJointLocationsEXT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(jointCount 'uint32_t')
		(jointLocations 'XrHandJointLocationEXT*')
	)
]
