Class {
	#name : #XrVector4sFB,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-3-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVector4sFB class >> fields [

	^ #(
		(x 'int16_t')
		(y 'int16_t')
		(z 'int16_t')
		(w 'int16_t')
	)
]
