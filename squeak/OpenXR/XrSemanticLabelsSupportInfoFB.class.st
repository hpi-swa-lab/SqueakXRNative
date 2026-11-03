Class {
	#name : #XrSemanticLabelsSupportInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrSemanticLabelsSupportInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrSemanticLabelsSupportFlagsFB')
		(recognizedLabels 'char*')
	)
]
