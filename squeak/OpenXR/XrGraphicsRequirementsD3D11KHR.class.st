Class {
	#name : #XrGraphicsRequirementsD3D11KHR,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-2-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrGraphicsRequirementsD3D11KHR class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(adapterLuid 'void')
		(minFeatureLevel 'void')
	)
]
