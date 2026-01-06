Class {
	#name : #SRAudioSource,
	#superclass : #Object,
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/19/2025 16:54'
}
SRAudioSource >> initialize [

	| source |
	source := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: source.
	self checkError: 'alGenSourcesN:'.
]
