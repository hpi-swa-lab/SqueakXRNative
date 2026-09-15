Class {
	#name : #SRInputDebugger,
	#superclass : #SRPlane,
	#instVars : [
		'hitcube',
		'btncube',
		'analogcube'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:00'
}
SRInputDebugger >> initialize [ 

	super initialize.
	
	hitcube := (SRCube new 
		scale: 3cm asVector3;
		color: Color red
	).
	self addChild: hitcube.
	
	btncube := (SRCube new
		scale: 3cm asVector3;
		color: Color green
	).
	self addChild: btncube.
	
	analogcube := (SRCube new
		scale: 3cm asVector3;
		color: Color black
	).
	self addChild: analogcube.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:08'
}
SRInputDebugger >> onInput: anInputEvent [

	anInputEvent point ifNotNil: [:p | hitcube globalTranslation: p ].
	anInputEvent isCursorEnterEvent ifTrue: [	hitcube color: Color red. ].
	anInputEvent isCursorLeaveEvent ifTrue: [ hitcube color: Color gray. ].
	
	anInputEvent isButtonEvent ifTrue: [
		btncube globalTranslation: anInputEvent point.
		anInputEvent pressed ifTrue: [
			btncube color: Color green.
		] ifFalse: [ btncube color: Color gray. ]
	].

	anInputEvent isAnalogEvent ifTrue: [ | color t |
		analogcube globalTranslation: anInputEvent point.
		t := anInputEvent value isPoint ifTrue: [
			anInputEvent value dist: (0@0)
		] ifFalse: [ anInputEvent value ].
		color := Color gray mixed: (1 - t) with: Color blue.
		analogcube color: color.
	].
]
