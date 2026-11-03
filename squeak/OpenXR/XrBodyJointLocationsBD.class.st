Class {
	#name : #XrBodyJointLocationsBD,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-4-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrBodyJointLocationsBD class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(allJointPosesTracked 'XrBool32')
		(jointLocationCount 'uint32_t')
		(jointLocations 'XrBodyJointLocationBD*')
	)
]
