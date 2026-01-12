Class {
	#name : #STBVorbis,
	#superclass : #ExternalLibrary,
	#category : #'OpenAL-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 15:57'
}
STBVorbis class >> moduleName [

	^ 'stb_vorbis'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/9/2026 16:58'
}
STBVorbis >> close: file [

	<cdecl: void 'stb_vorbis_close'(void*)>
	^ self externalCallFailed

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 16:41'
}
STBVorbis >> getError: f [

	<cdecl: int 'stb_vorbis_get_error'(void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 17:19'
}
STBVorbis >> getInfo: f [

	<cdecl: STBVorbisInfo 'stb_vorbis_get_info'(void*)>
	^ self externalCallFailed

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 17:18'
}
STBVorbis >> getSamplesShort: f channels: channels buffer: buffer length: length [

	<cdecl: int 'stb_vorbis_get_samples_short'(void*, int, int16_t**, int)>
	^ self externalCallFailed

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 16:38'
}
STBVorbis >> openFilename: filename error: error alloc: alloc [

	<cdecl: void* 'stb_vorbis_open_filename'(char*, int*, void*)>
	^ self externalCallFailed

]
