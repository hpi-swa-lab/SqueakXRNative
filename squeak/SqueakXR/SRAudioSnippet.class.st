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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioSnippet >> ensureReady [

	buffer ifNil: [self setup].
	buffer ifNil: [^ false].
	self ensureFileLoaded.
	^ true
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioSnippet >> loadFilepath: aFilepathString [

	| bufferPointer count dataBuffer error file info length |
	self class audioEnabled ifFalse: [^ self].
	(FileDirectory default fileExists: aFilepathString) ifFalse: [
		^ self error: 'Audio file not found: ', aFilepathString].
	error := ExternalType int allocate.
	file := STBVorbis default openFilename: aFilepathString error: error alloc: nil.
	file isNull ifTrue: [
		^ self error: 'stb_vorbis cannot open ', aFilepathString, ' (error ', error first printString, ')'].
	info := STBVorbis default getInfo: file.
	info channels > 1 ifTrue: [
		STBVorbis default close: file.
		^ self error: 'Loading OGG files with more than 1 channel is not supported'].
	length := STBVorbis default streamLengthInSamples: file.
	dataBuffer := ExternalType int16_t allocateExternal: length * info channels.
	bufferPointer := ExternalType int64_t allocate.
	bufferPointer at: 1 put: dataBuffer getHandle asInteger.
	count := STBVorbis default getSamplesShort: file channels: info channels buffer: bufferPointer length: length.
	
	self unbindFromCurrentSource.
	currentSource := nil.
	OpenAL alBufferDataBuffer: buffer first
		format: AlDefines alFormatMono16
		data: dataBuffer
		size: count * info channels * 2
		samplerate: info sampleRate.
	self checkErrorAl.
	
	dataBuffer free.
	STBVorbis default close: file.
]

{
	#category : #playback,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioSnippet >> playOn: aSource [

	self ensureReady ifFalse: [^ self].

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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioSnippet >> setup [

	self ensureOpenAL ifFalse: [^ self].
	buffer := ExternalType uint32_t allocate.
	OpenAL alGenBuffersN: 1 buffers: buffer.
	self checkErrorAl.
	isFileDirty := true.
]
