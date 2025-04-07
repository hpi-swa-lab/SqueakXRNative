Class {
	#name : #XrBodyJointLocationsFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{ #category : #'as yet unclassified' }
XrBodyJointLocationsFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(isActive 'XrBool32')
		(confidence 'float')
		(jointCount 'uint32_t')
		(jointLocations 'XrBodyJointLocationFB*')
		(skeletonChangedCount 'uint32_t')
		(time 'XrTime')
	)
]
