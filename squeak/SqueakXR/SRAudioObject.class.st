Class {
	#name : #SRAudioObject,
	#superclass : #Object,
	#classVars : [
		'ALContext',
		'ALDevice'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'error checking',
	#'squeak_changestamp' : 'leo 11/5/2026 15:21'
}
SRAudioObject class >> checkErrorAl [

	| code matches |
	code := OpenAL alGetError.
	code = AlDefines alNoError ifTrue: [^ self].
	code := code asString.
	matches := OrderedCollection new.
	AlDefines class methodsDo: [:m |
		((m getSource asString includesSubstring: code asString)
		and: [(m selector includesSubstring: 'alc') not]) ifTrue: [matches add: m selector]].
	self error: 'AL error: ', (matches joinSeparatedBy: '; ').
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'leo 11/5/2026 15:21'
}
SRAudioObject class >> checkErrorAlc [

	| code matches |
	code := OpenAL alcGetErrorDevice: ALDevice.
	code = AlDefines alcNoError ifTrue: [^ self].
	code := code asString.
	matches := OrderedCollection new.
	AlDefines class methodsDo: [:m |
		((m getSource asString includesSubstring: code asString)
		and: [m selector includesSubstring: 'alc']) ifTrue: [matches add: m selector]].
	self error: 'ALC error: ', (matches joinSeparatedBy: '; ').
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:13'
}
SRAudioObject class >> discardExternalObjects [

	ALContext := nil.
	ALDevice := nil.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:29'
}
SRAudioObject class >> ensureOpenAL [	
	
	self isReady ifFalse: [
		self setup].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:31'
}
SRAudioObject class >> initialize [

	" self initialize "

	super initialize.
	Smalltalk addToStartUpList: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:15'
}
SRAudioObject class >> isReady [

	self assert: (ALContext isNil xor: ALDevice isNil) not
		description: 'Inconsistent state, only one of ALContext and ALDevice is nil'.
	^ ALContext notNil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:27'
}
SRAudioObject class >> setup [	
	
	| deviceName |
	self isReady ifTrue: [
		self teardown].
	
	ALDevice := OpenAL alcOpenDeviceDevicename: nil.
	ALDevice ifNil: [
		Transcript showln: self class name, ': Failed to open audio device!'.
		^ self].
	self checkErrorAlc.
	
	ALContext := OpenAL alcCreateContextDevice: ALDevice attrlist: nil.
	ALContext ifNil: [
		OpenAL alcCloseDevice: ALDevice.
		Transcript showln: self class name, ': Failed to create audio context'.
		ALDevice := nil.
		^ self].
	self checkErrorAlc.
	
	(OpenAL alcMakeContextCurrentContext: ALContext) = 0 ifTrue: [
		OpenAL alcDestroyContext: ALContext.
		OpenAL alcCloseDevice: ALDevice.
		Transcript showln: self class name, ': Could not set an audio context!'.
		ALDevice := nil.
		ALContext := nil].
	self checkErrorAlc.
	
	deviceName := OpenAL alcGetStringDevice: ALDevice param: AlDefines alcAllDevicesSpecifier.
	Transcript showln: self class name, ': Opened "', deviceName, '"'.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:30'
}
SRAudioObject class >> startUp: resuming [

	resuming ifFalse: [^ self].

	self discardExternalObjects;
		allSubInstancesDo: #discardExternalObjects;
		setup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/5/2026 15:17'
}
SRAudioObject class >> teardown [

	self isReady ifFalse: [^ self].
	
	self allSubInstancesDo: #cleanup.

	ALContext ifNotNil: [
		OpenAL alcMakeContextCurrentContext: nil.
		OpenAL alcDestroyContext: ALContext.
		ALContext := nil].
	ALDevice ifNotNil: [
 		OpenAL alcCloseDevice: ALDevice.
		ALDevice := nil].
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'leo 11/5/2026 15:23'
}
SRAudioObject >> checkErrorAl [

	self class checkErrorAl
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'leo 11/5/2026 15:23'
}
SRAudioObject >> checkErrorAlc [

	self class checkErrorAlc
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/4/2026 17:11'
}
SRAudioObject >> cleanup [

	self subclassResponsibility
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:13'
}
SRAudioObject >> discardExternalObjects [

	self subclassResponsibility
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:28'
}
SRAudioObject >> ensureOpenAL [

	self class ensureOpenAL.
]

{
	#category : #finalization,
	#'squeak_changestamp' : 'leo 11/4/2026 17:16'
}
SRAudioObject >> finalize [

	self cleanup.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo 11/4/2026 17:10'
}
SRAudioObject >> initialize [

	super initialize.
	FinalizationRegistry default add: self.
]
