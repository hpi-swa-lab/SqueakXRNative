Class {
	#name : #SRAudioObject,
	#superclass : #Object,
	#classVars : [
		'ALContext',
		'ALDevice',
		'AudioEnabled'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject class >> audioEnabled [
	<preference: 'Audio enabled'
		category: 'SqueakXR'
		description: 'Whether SqueakXR uses OpenAL at all. OpenAL calls have been taking the VM down, so audio is off by default; while this is false nothing under SRAudio* issues an OpenAL call.'
		type: #Boolean>
	^ AudioEnabled ifNil: [AudioEnabled := false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:29'
}
SRAudioObject class >> audioEnabled: aBoolean [
	"Disabling releases the device here: once the flag is false every OpenAL entry point
	is gated, so nothing would reach #teardown later."

	AudioEnabled := aBoolean.
	aBoolean ifFalse: [self teardown].
]

{
	#category : #'error checking',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject class >> checkErrorAl [

	| code matches |
	self audioEnabled ifFalse: [^ self].
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject class >> checkErrorAlc [

	| code matches |
	self audioEnabled ifFalse: [^ self].
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject class >> ensureOpenAL [	
	
	"Answers whether OpenAL may be called. Callers must not issue an FFI call when this is false."

	self audioEnabled ifFalse: [^ false].
	self isReady ifFalse: [self setup].
	^ self isReady
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject class >> setup [	
	
	| deviceName |
	self audioEnabled ifFalse: [^ self].
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/6/2026 15:06'
}
SRAudioObject class >> startUp: resuming [

	"A startUp: that raises aborts processStartUpList:, so every hook registered
	 after this one is silently skipped. Audio is not worth taking the rest of
	 the image's startup down for."
	resuming ifFalse: [^ self].

	[self discardExternalObjects;
		allSubInstancesDo: #discardExternalObjects;
		setup]
			on: Error
			do: [:e | Transcript showln: self name, ' startUp: failed: ', e messageText].
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:25'
}
SRAudioObject >> ensureOpenAL [

	^ self class ensureOpenAL
]

{
	#category : #finalization,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 13:53'
}
SRAudioObject >> finalize [

	"Finalization runs after the OpenAL context may be gone, and deleting a source or
	buffer without one takes the VM down."

	ALContext ifNotNil: [self cleanup].
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:27'
}
SRAudioObject >> initialize [

	super initialize.
	"Nothing to release while audio is off: no device, no source, no buffer is ever created."
	self class audioEnabled ifTrue: [
		FinalizationRegistry default add: self].
]
