Class {
	#name : #XrWorldMeshBlockRequestML,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-6-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrWorldMeshBlockRequestML class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(uuid 'XrUuidEXT')
		(lod 'XrWorldMeshDetectorLodML')
	)
]
