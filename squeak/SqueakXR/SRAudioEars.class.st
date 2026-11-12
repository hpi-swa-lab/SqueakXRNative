Class {
	#name : #SRAudioEars,
	#superclass : #SRObject,
	#instVars : [
		'listener'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:20'
}
SRAudioEars >> initialize [

	super initialize.
	listener := SRAudioListener new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioEars >> step: delta [

	listener
		position: self globalTranslation;
		forward: self forward up: self up.
]
