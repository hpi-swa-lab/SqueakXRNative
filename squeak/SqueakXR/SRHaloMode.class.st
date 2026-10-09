Class {
	#name : #SRHaloMode,
	#superclass : #Object,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:06'
}
SRHaloMode class >> forbid [
	"I don't want a halo and my children may not have one either!"
	^ #forbid
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:06'
}
SRHaloMode class >> ignore [
	"I don't want a Halo but my children may have one."
	^ #ignore
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:08'
}
SRHaloMode class >> want [
	"I want a halo, and my children may also have one."
	^ #want
]
