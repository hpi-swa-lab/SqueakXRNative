Class {
	#name : #SRAudioSource,
	#superclass : #SRAudioObject,
	#instVars : [
		'source'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/10/2026 16:20'
}
SRAudioSource class >> initialize [

	"Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self."
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
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> bindSnippet: aSnippet [

	self ensureReady.
	OpenAL alSourceiSource: source first param: AlDefines alBuffer value: aSnippet buffer first.
	self checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> cleanup [

	source ifNotNil: [
		OpenAL alDeleteSourcesN: 1 sources: source.
		self checkErrorAl.
		source := nil]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:19'
}
SRAudioSource >> discardExternalObjects [

	source := nil.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 17:57'
}
SRAudioSource >> ensureReady [

	source ifNil: [
		self setup].
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'leo 11/4/2026 17:47'
}
SRAudioSource >> initialize [

	super initialize.
	self position: Vector3 zero.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:57'
}
SRAudioSource >> play: audio [

	audio playOn: self.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> position: aVector3 [

	self ensureReady.
	OpenAL
		alSourcefvSource: source first
		param: AlDefines alPosition
		values: aVector3.
	self checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> rewind [

	self ensureReady.
	OpenAL alSourceRewindSource: source first.
	self checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> setup [

	self ensureOpenAL.
	source := ExternalType uint32_t allocate.
	OpenAL alGenSourcesN: 1 sources: source.
	self checkErrorAl.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 1/9/2026 17:22'
}
SRAudioSource >> source [

	^ source
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'MCPServer (leo) 11/5/2026 17:56'
}
SRAudioSource >> stop [

	self ensureReady.
	OpenAL alSourceStopSource: source first.
	self checkErrorAl.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:26'
}
SRAudioSource >> unbindBuffer [

	source ifNotNil: [
		OpenAL alSourceiSource: source first param: AlDefines alBuffer value: 0.
		self checkErrorAl.].
]
