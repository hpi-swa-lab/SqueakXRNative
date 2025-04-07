Class {
	#name : #XrVector4sFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{ #category : #'as yet unclassified' }
XrVector4sFB class >> fields [

	^ #(
		(x 'int16_t')
		(y 'int16_t')
		(z 'int16_t')
		(w 'int16_t')
	)
]
