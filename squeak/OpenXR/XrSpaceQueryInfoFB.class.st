Class {
	#name : #XrSpaceQueryInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSpaceQueryInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(queryAction 'XrSpaceQueryActionFB')
		(maxResultCount 'uint32_t')
		(timeout 'XrDuration')
		(filter 'XrSpaceFilterInfoBaseHeaderFB*')
		(excludeFilter 'XrSpaceFilterInfoBaseHeaderFB*')
	)
]
