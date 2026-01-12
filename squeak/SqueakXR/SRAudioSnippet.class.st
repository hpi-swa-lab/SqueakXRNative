Class {
	#name : #SRAudioSnippet,
	#superclass : #Object,
	#instVars : [
		'buffer',
		'currentSource'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/8/2026 18:16'
}
SRAudioSnippet class >> initialize [

	Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:03'
}
SRAudioSnippet class >> shutDown: quitting [

	quitting ifFalse: [^ self].
	self allInstances do: #cleanup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:03'
}
SRAudioSnippet class >> startUp: resuming [

	resuming ifFalse: [^ self].
	self allInstances do: #setup.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 1/9/2026 17:54'
}
SRAudioSnippet >> buffer [

	^ buffer
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/9/2026 18:00'
}
SRAudioSnippet >> cleanup [

	self unbindFromCurrentSource.
	buffer ifNotNil: [
		OpenAL alDeleteBuffersN: 1 buffers: buffer.
		self checkErrorAl.
		buffer := nil]
]

{
	#category : #finalizing,
	#'squeak_changestamp' : 'lege 1/8/2026 18:20'
}
SRAudioSnippet >> finalize [

	self cleanup.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 1/8/2026 18:17'
}
SRAudioSnippet >> initialize [

	super initialize.
	self setup.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/12/2026 16:22'
}
SRAudioSnippet >> loadFilepath: aFilepathString [

	| bufferPointer count dataBuffer error file info |
	error := ExternalType int allocate.
	file := STBVorbis default openFilename: aFilepathString error: error alloc: nil.
	STBVorbis default getError: file.
	info := STBVorbis default getInfo: file.
	info channels > 1 ifTrue: [
		self error: 'Loading OGG files with more than 1 channel is not supported'.
		^ self].
	dataBuffer := ExternalType int16_t allocateExternal: info setupMemoryRequired.
	bufferPointer := ExternalType int64_t allocate.
	bufferPointer at: 1 put: dataBuffer getHandle asInteger.
	count := STBVorbis default getSamplesShort: file channels: info channels buffer: bufferPointer length: info setupMemoryRequired.
	
	self unbindFromCurrentSource.
	OpenAL alBufferDataBuffer: buffer first
		format: AlDefines alFormatMono16
		data: dataBuffer
		size: dataBuffer size * 2
		samplerate: info sampleRate.
	SRAudio instance checkErrorAl.
	
	STBVorbis default close: file.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 17:57'
}
SRAudioSnippet >> playOn: aSource [

	aSource = currentSource ifTrue: [
		currentSource unbindBuffer].
	
	currentSource := aSource.
	aSource bindSnippet: self.
	OpenAL alSourcePlaySource: aSource source first.
	SRAudio instance checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/9/2026 17:44'
}
SRAudioSnippet >> setup [

	SRAudio instance ensureOpenAL.
	buffer := ExternalType uint32_t allocate.
	OpenAL alGenBuffersN: 1 buffers: buffer.
	SRAudio instance checkErrorAl.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 18:00'
}
SRAudioSnippet >> unbindFromCurrentSource [

	currentSource ifNotNil: [
		currentSource unbindBuffer]
]
