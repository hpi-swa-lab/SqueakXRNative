Class {
	#name : #SRXrHandJoints,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-HandTracking'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/26/2026 17:05'
}
SRXrHandJoints class >> fields [

	" self defineFields "
	^ #(
		(leftJointLocations 'XrHandJointLocationEXT[26]')
		(rightJointLocations 'XrHandJointLocationEXT[26]')
		) 
]
