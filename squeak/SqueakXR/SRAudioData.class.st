Class {
	#name : #SRAudioData,
	#superclass : #SRAudioObject,
	#instVars : [
		'currentSource'
	],
	#category : #'SqueakXR-Audio'
}

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/13/2026 11:50'
}
SRAudioData >> cleanup [

	self subclassResponsibility
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 1/13/2026 11:48'
}
SRAudioData >> initialize [

	super initialize.
	self setup.
]

{
	#category : #playback,
	#'squeak_changestamp' : 'lege 1/13/2026 11:49'
}
SRAudioData >> playOn: aSource [

	self subclassResponsibility
]

{
	#category : #lifecycle,
	#'squeak_changestamp' : 'lege 1/13/2026 11:49'
}
SRAudioData >> setup [

	self subclassResponsibility
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/13/2026 11:48'
}
SRAudioData >> unbindFromCurrentSource [

	currentSource ifNotNil: [
		currentSource unbindBuffer]
]
