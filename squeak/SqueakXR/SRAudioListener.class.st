Class {
	#name : #SRAudioListener,
	#superclass : #SRAudioObject,
	#instVars : [
		'floatBuffer'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 18:20'
}
SRAudioListener >> cleanup [
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 18:37'
}
SRAudioListener >> forward: forwardVector up: upVector [

	SRAudio instance ensureOpenAL.
	floatBuffer atAll: (1 to: 3) putAll: forwardVector.
	floatBuffer atAll: (4 to: 6) putAll: upVector.
	OpenAL alListenerfvParam: AlDefines alOrientation values: floatBuffer.
	SRAudio instance checkErrorAl.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 18:37'
}
SRAudioListener >> initialize [

	super initialize.
	floatBuffer := Float32Array new: 6.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 11/4/2026 18:23'
}
SRAudioListener >> position: aVector3 [

	SRAudio instance ensureOpenAL.
	OpenAL alListenerfvParam: AlDefines alPosition values: aVector3.
	SRAudio instance checkErrorAl.
]
