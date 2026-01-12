Class {
	#name : #AlFunctions,
	#superclass : #ExternalLibrary,
	#category : #'OpenAL-Functions-Generated'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions class >> moduleName [

	^ 'openal'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBuffer3fBuffer: buffer param: param value1: value1 value2: value2 value3: value3 [
	"
	buffer - ALuint
	param - ALenum
	value1 - ALfloat
	value2 - ALfloat
	value3 - ALfloat"
	<generated>
	<cdecl: void 'alBuffer3f' (uint32_t, int32_t, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBuffer3iBuffer: buffer param: param value1: value1 value2: value2 value3: value3 [
	"
	buffer - ALuint
	param - ALenum
	value1 - ALint
	value2 - ALint
	value3 - ALint"
	<generated>
	<cdecl: void 'alBuffer3i' (uint32_t, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBufferDataBuffer: buffer format: format data: data size: size samplerate: samplerate [
	"
	buffer - ALuint
	format - ALenum
	data - const ALvoid *
	size - ALsizei
	samplerate - ALsizei"
	<generated>
	<cdecl: void 'alBufferData' (uint32_t, int32_t, void*, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBufferfBuffer: buffer param: param value: value [
	"
	buffer - ALuint
	param - ALenum
	value - ALfloat"
	<generated>
	<cdecl: void 'alBufferf' (uint32_t, int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBufferfvBuffer: buffer param: param values: values [
	"
	buffer - ALuint
	param - ALenum
	values - const ALfloat *"
	<generated>
	<cdecl: void 'alBufferfv' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBufferiBuffer: buffer param: param value: value [
	"
	buffer - ALuint
	param - ALenum
	value - ALint"
	<generated>
	<cdecl: void 'alBufferi' (uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alBufferivBuffer: buffer param: param values: values [
	"
	buffer - ALuint
	param - ALenum
	values - const ALint *"
	<generated>
	<cdecl: void 'alBufferiv' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDeleteBuffersN: n buffers: buffers [
	"
	n - ALsizei
	buffers - const ALuint *"
	<generated>
	<cdecl: void 'alDeleteBuffers' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDeleteSourcesN: n sources: sources [
	"
	n - ALsizei
	sources - const ALuint *"
	<generated>
	<cdecl: void 'alDeleteSources' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDisableCapability: capability [
	"
	capability - ALenum"
	<generated>
	<cdecl: void 'alDisable' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDistanceModel: distanceModel [
	"
	distanceModel - ALenum"
	<generated>
	<cdecl: void 'alDistanceModel' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDopplerFactorValue: value [
	"
	value - ALfloat"
	<generated>
	<cdecl: void 'alDopplerFactor' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alDopplerVelocityValue: value [
	"
	value - ALfloat"
	<generated>
	<cdecl: void 'alDopplerVelocity' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alEnableCapability: capability [
	"
	capability - ALenum"
	<generated>
	<cdecl: void 'alEnable' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGenBuffersN: n buffers: buffers [
	"
	n - ALsizei
	buffers - ALuint *"
	<generated>
	<cdecl: void 'alGenBuffers' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGenSourcesN: n sources: sources [
	"
	n - ALsizei
	sources - ALuint *"
	<generated>
	<cdecl: void 'alGenSources' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBooleanParam: param [
	"
	param - ALenum"
	<generated>
	<cdecl: char8_t 'alGetBoolean' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBooleanvParam: param values: values [
	"
	param - ALenum
	values - ALboolean *"
	<generated>
	<cdecl: void 'alGetBooleanv' (int32_t, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBuffer3fBuffer: buffer param: param value1: value1 value2: value2 value3: value3 [
	"
	buffer - ALuint
	param - ALenum
	value1 - ALfloat *
	value2 - ALfloat *
	value3 - ALfloat *"
	<generated>
	<cdecl: void 'alGetBuffer3f' (uint32_t, int32_t, float*, float*, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBuffer3iBuffer: buffer param: param value1: value1 value2: value2 value3: value3 [
	"
	buffer - ALuint
	param - ALenum
	value1 - ALint *
	value2 - ALint *
	value3 - ALint *"
	<generated>
	<cdecl: void 'alGetBuffer3i' (uint32_t, int32_t, int32_t*, int32_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBufferfBuffer: buffer param: param value: value [
	"
	buffer - ALuint
	param - ALenum
	value - ALfloat *"
	<generated>
	<cdecl: void 'alGetBufferf' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBufferfvBuffer: buffer param: param values: values [
	"
	buffer - ALuint
	param - ALenum
	values - ALfloat *"
	<generated>
	<cdecl: void 'alGetBufferfv' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBufferiBuffer: buffer param: param value: value [
	"
	buffer - ALuint
	param - ALenum
	value - ALint *"
	<generated>
	<cdecl: void 'alGetBufferi' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetBufferivBuffer: buffer param: param values: values [
	"
	buffer - ALuint
	param - ALenum
	values - ALint *"
	<generated>
	<cdecl: void 'alGetBufferiv' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetDoubleParam: param [
	"
	param - ALenum"
	<generated>
	<cdecl: double 'alGetDouble' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetDoublevParam: param values: values [
	"
	param - ALenum
	values - ALdouble *"
	<generated>
	<cdecl: void 'alGetDoublev' (int32_t, double*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetEnumValueEname: ename [
	"
	ename - const ALchar *"
	<generated>
	<cdecl: int32_t 'alGetEnumValue' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetError [
	"
"
	<generated>
	<cdecl: int32_t 'alGetError' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetFloatParam: param [
	"
	param - ALenum"
	<generated>
	<cdecl: float 'alGetFloat' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetFloatvParam: param values: values [
	"
	param - ALenum
	values - ALfloat *"
	<generated>
	<cdecl: void 'alGetFloatv' (int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetIntegerParam: param [
	"
	param - ALenum"
	<generated>
	<cdecl: int32_t 'alGetInteger' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetIntegervParam: param values: values [
	"
	param - ALenum
	values - ALint *"
	<generated>
	<cdecl: void 'alGetIntegerv' (int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListener3fParam: param value1: value1 value2: value2 value3: value3 [
	"
	param - ALenum
	value1 - ALfloat *
	value2 - ALfloat *
	value3 - ALfloat *"
	<generated>
	<cdecl: void 'alGetListener3f' (int32_t, float*, float*, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListener3iParam: param value1: value1 value2: value2 value3: value3 [
	"
	param - ALenum
	value1 - ALint *
	value2 - ALint *
	value3 - ALint *"
	<generated>
	<cdecl: void 'alGetListener3i' (int32_t, int32_t*, int32_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListenerfParam: param value: value [
	"
	param - ALenum
	value - ALfloat *"
	<generated>
	<cdecl: void 'alGetListenerf' (int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListenerfvParam: param values: values [
	"
	param - ALenum
	values - ALfloat *"
	<generated>
	<cdecl: void 'alGetListenerfv' (int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListeneriParam: param value: value [
	"
	param - ALenum
	value - ALint *"
	<generated>
	<cdecl: void 'alGetListeneri' (int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetListenerivParam: param values: values [
	"
	param - ALenum
	values - ALint *"
	<generated>
	<cdecl: void 'alGetListeneriv' (int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetProcAddressFname: fname [
	"
	fname - const ALchar *"
	<generated>
	<cdecl: void* 'alGetProcAddress' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSource3fSource: source param: param value1: value1 value2: value2 value3: value3 [
	"
	source - ALuint
	param - ALenum
	value1 - ALfloat *
	value2 - ALfloat *
	value3 - ALfloat *"
	<generated>
	<cdecl: void 'alGetSource3f' (uint32_t, int32_t, float*, float*, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSource3iSource: source param: param value1: value1 value2: value2 value3: value3 [
	"
	source - ALuint
	param - ALenum
	value1 - ALint *
	value2 - ALint *
	value3 - ALint *"
	<generated>
	<cdecl: void 'alGetSource3i' (uint32_t, int32_t, int32_t*, int32_t*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSourcefSource: source param: param value: value [
	"
	source - ALuint
	param - ALenum
	value - ALfloat *"
	<generated>
	<cdecl: void 'alGetSourcef' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSourcefvSource: source param: param values: values [
	"
	source - ALuint
	param - ALenum
	values - ALfloat *"
	<generated>
	<cdecl: void 'alGetSourcefv' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSourceiSource: source param: param value: value [
	"
	source - ALuint
	param -  ALenum
	value - ALint *"
	<generated>
	<cdecl: void 'alGetSourcei' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetSourceivSource: source param: param values: values [
	"
	source - ALuint
	param -  ALenum
	values - ALint *"
	<generated>
	<cdecl: void 'alGetSourceiv' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alGetStringParam: param [
	"
	param - ALenum"
	<generated>
	<cdecl: char8_t* 'alGetString' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alIsBuffer: buffer [
	"
	buffer - ALuint"
	<generated>
	<cdecl: char8_t 'alIsBuffer' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alIsEnabledCapability: capability [
	"
	capability - ALenum"
	<generated>
	<cdecl: char8_t 'alIsEnabled' (int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alIsExtensionPresentExtname: extname [
	"
	extname - const ALchar *"
	<generated>
	<cdecl: char8_t 'alIsExtensionPresent' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alIsSource: source [
	"
	source - ALuint"
	<generated>
	<cdecl: char8_t 'alIsSource' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListener3fParam: param value1: value1 value2: value2 value3: value3 [
	"
	param - ALenum
	value1 - ALfloat
	value2 - ALfloat
	value3 - ALfloat"
	<generated>
	<cdecl: void 'alListener3f' (int32_t, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListener3iParam: param value1: value1 value2: value2 value3: value3 [
	"
	param - ALenum
	value1 - ALint
	value2 - ALint
	value3 - ALint"
	<generated>
	<cdecl: void 'alListener3i' (int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListenerfParam: param value: value [
	"
	param - ALenum
	value - ALfloat"
	<generated>
	<cdecl: void 'alListenerf' (int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListenerfvParam: param values: values [
	"
	param - ALenum
	values - const ALfloat *"
	<generated>
	<cdecl: void 'alListenerfv' (int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListeneriParam: param value: value [
	"
	param - ALenum
	value - ALint"
	<generated>
	<cdecl: void 'alListeneri' (int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alListenerivParam: param values: values [
	"
	param - ALenum
	values - const ALint *"
	<generated>
	<cdecl: void 'alListeneriv' (int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSource3fSource: source param: param value1: value1 value2: value2 value3: value3 [
	"
	source - ALuint
	param - ALenum
	value1 - ALfloat
	value2 - ALfloat
	value3 - ALfloat"
	<generated>
	<cdecl: void 'alSource3f' (uint32_t, int32_t, float, float, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSource3iSource: source param: param value1: value1 value2: value2 value3: value3 [
	"
	source - ALuint
	param - ALenum
	value1 - ALint
	value2 - ALint
	value3 - ALint"
	<generated>
	<cdecl: void 'alSource3i' (uint32_t, int32_t, int32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcePauseSource: source [
	"
	source - ALuint"
	<generated>
	<cdecl: void 'alSourcePause' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcePausevN: n sources: sources [
	"
	n - ALsizei
	sources - const ALuint *"
	<generated>
	<cdecl: void 'alSourcePausev' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcePlaySource: source [
	"
	source - ALuint"
	<generated>
	<cdecl: void 'alSourcePlay' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcePlayvN: n sources: sources [
	"
	n - ALsizei
	sources - const ALuint *"
	<generated>
	<cdecl: void 'alSourcePlayv' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceQueueBuffersSource: source nb: nb buffers: buffers [
	"
	source - ALuint
	nb - ALsizei
	buffers - const ALuint *"
	<generated>
	<cdecl: void 'alSourceQueueBuffers' (uint32_t, int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceRewindSource: source [
	"
	source - ALuint"
	<generated>
	<cdecl: void 'alSourceRewind' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceRewindvN: n sources: sources [
	"
	n - ALsizei
	sources - const ALuint *"
	<generated>
	<cdecl: void 'alSourceRewindv' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceStopSource: source [
	"
	source - ALuint"
	<generated>
	<cdecl: void 'alSourceStop' (uint32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceStopvN: n sources: sources [
	"
	n - ALsizei
	sources - const ALuint *"
	<generated>
	<cdecl: void 'alSourceStopv' (int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceUnqueueBuffersSource: source nb: nb buffers: buffers [
	"
	source - ALuint
	nb - ALsizei
	buffers - ALuint *"
	<generated>
	<cdecl: void 'alSourceUnqueueBuffers' (uint32_t, int32_t, uint32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcefSource: source param: param value: value [
	"
	source - ALuint
	param - ALenum
	value - ALfloat"
	<generated>
	<cdecl: void 'alSourcef' (uint32_t, int32_t, float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourcefvSource: source param: param values: values [
	"
	source - ALuint
	param - ALenum
	values - const ALfloat *"
	<generated>
	<cdecl: void 'alSourcefv' (uint32_t, int32_t, float*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceiSource: source param: param value: value [
	"
	source - ALuint
	param - ALenum
	value - ALint"
	<generated>
	<cdecl: void 'alSourcei' (uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSourceivSource: source param: param values: values [
	"
	source - ALuint
	param - ALenum
	values - const ALint *"
	<generated>
	<cdecl: void 'alSourceiv' (uint32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alSpeedOfSoundValue: value [
	"
	value - ALfloat"
	<generated>
	<cdecl: void 'alSpeedOfSound' (float)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCaptureCloseDevice: device [
	"
	device - ALCdevice *"
	<generated>
	<cdecl: char8_t 'alcCaptureCloseDevice' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCaptureOpenDeviceDevicename: devicename frequency: frequency format: format buffersize: buffersize [
	"
	devicename - const ALCchar *
	frequency - ALCuint
	format - ALCenum
	buffersize - ALCsizei"
	<generated>
	<cdecl: void* 'alcCaptureOpenDevice' (char8_t*, uint32_t, int32_t, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCaptureSamplesDevice: device buffer: buffer samples: samples [
	"
	device - ALCdevice *
	buffer - ALCvoid *
	samples - ALCsizei"
	<generated>
	<cdecl: void 'alcCaptureSamples' (void*, void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCaptureStartDevice: device [
	"
	device - ALCdevice *"
	<generated>
	<cdecl: void 'alcCaptureStart' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCaptureStopDevice: device [
	"
	device - ALCdevice *"
	<generated>
	<cdecl: void 'alcCaptureStop' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCloseDevice: device [
	"
	device - ALCdevice *"
	<generated>
	<cdecl: char8_t 'alcCloseDevice' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcCreateContextDevice: device attrlist: attrlist [
	"
	device - ALCdevice *
	attrlist - const ALCint *"
	<generated>
	<cdecl: void* 'alcCreateContext' (void*, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcDestroyContext: context [
	"
	context - ALCcontext *"
	<generated>
	<cdecl: void 'alcDestroyContext' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetContextsDeviceContext: context [
	"
	context - ALCcontext *"
	<generated>
	<cdecl: void* 'alcGetContextsDevice' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetCurrentContext [
	"
"
	<generated>
	<cdecl: void* 'alcGetCurrentContext' ()>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetEnumValueDevice: device enumname: enumname [
	"
	device - ALCdevice *
	enumname - const ALCchar *"
	<generated>
	<cdecl: int32_t 'alcGetEnumValue' (void*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetErrorDevice: device [
	"
	device - ALCdevice *"
	<generated>
	<cdecl: int32_t 'alcGetError' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetIntegervDevice: device param: param size: size values: values [
	"
	device - ALCdevice *
	param - ALCenum
	size - ALCsizei
	values - ALCint *"
	<generated>
	<cdecl: void 'alcGetIntegerv' (void*, int32_t, int32_t, int32_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetProcAddressDevice: device funcname: funcname [
	"
	device - ALCdevice *
	funcname - const ALCchar *"
	<generated>
	<cdecl: void* 'alcGetProcAddress' (void*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcGetStringDevice: device param: param [
	"
	device - ALCdevice *
	param - ALCenum"
	<generated>
	<cdecl: char8_t* 'alcGetString' (void*, int32_t)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcIsExtensionPresentDevice: device extname: extname [
	"
	device - ALCdevice *
	extname - const ALCchar *"
	<generated>
	<cdecl: char8_t 'alcIsExtensionPresent' (void*, char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcMakeContextCurrentContext: context [
	"
	context - ALCcontext *"
	<generated>
	<cdecl: char8_t 'alcMakeContextCurrent' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcOpenDeviceDevicename: devicename [
	"
	devicename - const ALCchar *"
	<generated>
	<cdecl: void* 'alcOpenDevice' (char8_t*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcProcessContext: context [
	"
	context - ALCcontext *"
	<generated>
	<cdecl: void 'alcProcessContext' (void*)>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/6/2026 17:46'
}
AlFunctions >> alcSuspendContext: context [
	"
	context - ALCcontext *"
	<generated>
	<cdecl: void 'alcSuspendContext' (void*)>
	^ self externalCallFailed
]
