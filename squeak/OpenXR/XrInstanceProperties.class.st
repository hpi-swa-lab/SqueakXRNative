Class {
	#name : #XrInstanceProperties,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrInstanceProperties class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(runtimeVersion 'XrVersion')
		(runtimeName 'char[128]')
	)
]
