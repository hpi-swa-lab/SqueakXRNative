Class {
	#name : #SXrHandJoints,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-Input'
}

{
	#category : #'field definition',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/26/2026 16:54'
}
SXrHandJoints class >> fields [
	^ #(
		(leftJointLocations 'XrHandJointLocationEXT[26]')
		(rightJointLocations 'XrHandJointLocationEXT[26]')
	)
]
