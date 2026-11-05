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
	#'squeak_changestamp' : 'leo 11/4/2026 19:38'
}
SRAudioPlayer >> initialize [

	super initialize.
	
	data := SRAudioSnippet fromFilepath: 'C:\Users\leona\Downloads\gun.ogg'.
	source := SRAudioSource new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:21'
}
SRAudioPlayer >> play [

	source play: data.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:19'
}
SRAudioPlayer >> step: delta [

	source position: self globalTranslation.
]
