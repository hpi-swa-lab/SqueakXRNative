Class {
	#name : #SRAudioSource,
	#superclass : #Object,
	#instVars : [
		'source'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:11'
}
SRAudioSource class >> initialize [

	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:03'
}
SRAudioSource class >> shutDown: quitting [

	quitting ifFalse: [^ self].
	self allInstances do: #cleanup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:03'
}
SRAudioSource class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self allInstances do: [:instance | instance setup].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:57'
}
SRAudioSource >> bindSnippet: aSnippet [

	OpenAL alSourceiSource: source first param: AlDefines alBuffer value: aSnippet buffer first.
	SRAudio instance checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/8/2026 18:22'
}
SRAudioSource >> cleanup [

	source ifNotNil: [
		OpenAL alDeleteSourcesN: 1 sources: source.
		SRAudio instance checkErrorAl.
		source := nil]
]

{
	#category : #finalizing,
	#'squeak_changestamp' : 'lege 1/8/2026 18:20'
}
SRAudioSource >> finalize [

	self cleanup.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 1/8/2026 18:11'
}
SRAudioSource >> initialize [

	super initialize.
	self setup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:57'
}
SRAudioSource >> play: audio [

	audio playOn: self.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/12/2026 17:27'
}
SRAudioSource >> position: aVector3 [

	OpenAL alSource3fSource: source first param: AlDefines alPosition
		value1: aVector3 x
		value2: aVector3 y
		value3: aVector3 z.
	"OpenAL alSourcefvSource: source first param: AlDefines alDirection values: aVector3."
	SRAudio instance checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/12/2026 16:57'
}
SRAudioSource >> setup [

	SRAudio instance ensureOpenAL.
	source := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: source.
	SRAudio instance checkErrorAl.
	OpenAL alSourceiSource: source first param: AlDefines alSourceRelative value: AlDefines alTrue.
	SRAudio instance checkErrorAl.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 1/9/2026 17:22'
}
SRAudioSource >> source [

	^ source
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:57'
}
SRAudioSource >> unbindBuffer [

	OpenAL alSourceiSource: source first param: AlDefines alBuffer value: 0.
	SRAudio instance checkErrorAl.
]
