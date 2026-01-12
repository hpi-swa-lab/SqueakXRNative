Class {
	#name : #STBVorbisInfo,
	#superclass : #ExternalStructure,
	#category : #'OpenAL-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 12/18/2025 17:23'
}
STBVorbisInfo class >> fields [

	" self defineFields "

	^ #(
		(sampleRate 'uint32_t ')
		(channels 'int')
		(setupMemoryRequired 'uint32_t')
		(setupTempMemoryRequired 'uint32_t')
		(tempMemoryRequired 'uint32_t')
		(maxFrameSize 'int')
	)
]
