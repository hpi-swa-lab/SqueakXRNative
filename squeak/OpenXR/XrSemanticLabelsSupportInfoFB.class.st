Class {
	#name : #XrSemanticLabelsSupportInfoFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrSemanticLabelsSupportInfoFB class >> fields [

	^ #(
		(type 'XrStructureType')
		(next 'void*')
		(flags 'XrSemanticLabelsSupportFlagsFB')
		(recognizedLabels 'char*')
	)
]
