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
	#'squeak_changestamp' : 'leo 11/5/2026 15:19'
}
SRAudioListener >> discardExternalObjects [
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioListener >> forward: forwardVector up: upVector [

	self ensureOpenAL ifFalse: [^ self].
	floatBuffer atAll: (1 to: 3) putAll: forwardVector.
	floatBuffer atAll: (4 to: 6) putAll: upVector.
	OpenAL alListenerfvParam: AlDefines alOrientation values: floatBuffer.
	self checkErrorAl.
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 11/12/2026 14:26'
}
SRAudioListener >> position: aVector3 [

	self ensureOpenAL ifFalse: [^ self].
	OpenAL alListenerfvParam: AlDefines alPosition values: aVector3.
	self checkErrorAl.
]
