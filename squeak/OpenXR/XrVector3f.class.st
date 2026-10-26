Class {
	#name : #XrVector3f,
	#superclass : #ExternalStructure,
	#category : #'OpenXR-Structs-1-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVector3f class >> fields [

	^ #(
		(x 'float')
		(y 'float')
		(z 'float')
	)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/23/2026 15:21'
}
XrVector3f >> asVector3 [ ^ self
]
