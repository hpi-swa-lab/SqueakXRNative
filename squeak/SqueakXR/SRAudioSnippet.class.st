Class {
	#name : #SRAudioSnippet,
	#superclass : #SRAudioData,
	#instVars : [
		'buffer',
		'filepath',
		'isFileDirty'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 19:12'
}
SRAudioSnippet class >> fromFilepath: aFilepahString [

	^ self new filepath: aFilepahString
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/10/2026 16:20'
}
SRAudioSnippet class >> initialize [

	"Smalltalk addToStartUpList: self.
	Smalltalk addToShutDownList: self."
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
	#category : #testing,
	#'squeak_changestamp' : 'leo 11/5/2026 17:38'
}
SRAudioSnippet >> canPlay [

	"TODO: make this more robust"
	^ filepath notNil
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:25'
}
SRAudioSnippet >> cleanup [

	self unbindFromCurrentSource.
	currentSource := nil.
	buffer ifNotNil: [
		OpenAL alDeleteBuffersN: 1 buffers: buffer.
		self checkErrorAl.
		buffer := nil]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:18'
}
SRAudioSnippet >> discardExternalObjects [

	currentSource := nil.
	buffer := nil.
]

{
	#category : #playback,
	#'squeak_changestamp' : 'leo 11/4/2026 17:35'
}
SRAudioSnippet >> ensureFileLoaded [

	(isFileDirty and: [self filepath notNil]) ifTrue: [
		self loadFilepath: self filepath.
		isFileDirty := false.]
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/4/2026 17:34'
}
SRAudioSnippet >> ensureReady [

	buffer ifNil: [self setup].
	self ensureFileLoaded.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 11/4/2026 17:36'
}
SRAudioSnippet >> filepath [

	^ filepath
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 11/4/2026 17:33'
}
SRAudioSnippet >> filepath: aFilepathString [

	filepath := aFilepathString.
	isFileDirty := true.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'leo 11/4/2026 17:33'
}
SRAudioSnippet >> initialize [

	super initialize.
	isFileDirty := true.
]

{
	#category : #playback,
	#'squeak_changestamp' : 'leo 11/5/2026 15:25'
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
	currentSource := nil.
	OpenAL alBufferDataBuffer: buffer first
		format: AlDefines alFormatMono16
		data: dataBuffer
		size: dataBuffer size * 2
		samplerate: info sampleRate.
	self checkErrorAl.
	
	STBVorbis default close: file.
]

{
	#category : #playback,
	#'squeak_changestamp' : 'leo 11/5/2026 15:25'
}
SRAudioSnippet >> playOn: aSource [

	self ensureReady.

	"TODO: currently there is a 1-1 relation between source and data,
	but technically multiple AL sources can share one buffer"
	aSource = currentSource
		ifTrue: [currentSource rewind]
		ifFalse: [
			currentSource ifNotNil: [currentSource unbindBuffer].
			currentSource := aSource.
			aSource bindSnippet: self].
	
	OpenAL alSourcePlaySource: aSource source first.
	self checkErrorAl.
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'leo 11/5/2026 15:25'
}
SRAudioSnippet >> setup [

	self ensureOpenAL.
	buffer := ExternalType uint32_t allocate.
	OpenAL alGenBuffersN: 1 buffers: buffer.
	self checkErrorAl.
	isFileDirty := true.
]
