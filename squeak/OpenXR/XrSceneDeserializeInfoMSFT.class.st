Class {
	#name : #XrSceneDeserializeInfoMSFT,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSceneDeserializeInfoMSFT class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(fragmentCount 'uint32_t')
		(fragments 'XrDeserializeSceneFragmentMSFT*')
	)
]
