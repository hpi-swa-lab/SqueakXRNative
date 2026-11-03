Class {
	#name : #XrActionSpaceCreateInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrActionSpaceCreateInfo class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(action 'XrAction')
		(subactionPath 'XrPath')
		(poseInActionSpace 'XrPosef')
	)
]
