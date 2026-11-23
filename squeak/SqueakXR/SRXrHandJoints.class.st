Class {
	#name : #SRXrHandJoints,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-HandTracking'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 16:14'
}
SRXrHandJoints class >> fields [

	" self defineFields "
	^ #(
		(leftJointLocations 'XrHandJointLocationEXT[26]')
		(rightJointLocations 'XrHandJointLocationEXT[26]')
		(leftIsActive 'XrBool32')
		(rightIsActive 'XrBool32')
		) 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 18:19'
}
SRXrHandJoints >> isActive [

	^ self leftIsActive value ~= 0 or: [self rightIsActive value ~= 0]
]
