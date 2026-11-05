Class {
	#name : #SRAudioPlayer,
	#superclass : #SRObject,
	#instVars : [
		'data',
		'source'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 17:37'
}
SRAudioPlayer >> filepath: aFilepathString [

	data filepath: aFilepathString.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 17:37'
}
SRAudioPlayer >> initialize [

	super initialize.
	
	data := SRAudioSnippet new.
	source := SRAudioSource new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 17:39'
}
SRAudioPlayer >> play [

	data canPlay ifTrue: [	
		source play: data].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:19'
}
SRAudioPlayer >> step: delta [

	source position: self globalTranslation.
]
