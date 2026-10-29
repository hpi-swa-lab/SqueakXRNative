"
A SRHaloButton is a button used in the context of halo actions

Instance Variables
clickAction - Called whenever the button is clicked on.
dragAction 	- Called when the button is dragged by a cursor.
grabAction 	- Called when grabbing this handle.
dropAction 	- Called then releasing this handle.
"
Class {
	#name : #SRHaloButton,
	#superclass : #SRObject,
	#instVars : [
		'clickAction',
		'dragAction',
		'dropAction',
		'cube',
		'text',
		'originalTransform',
		'grabAction',
		'minimumWidth'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:29'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:31'
}
SRHaloButton class >> padding [

	^ (1cm)@(1cm)@(0)
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:25'
}
SRHaloButton >> clickAction [
	^ clickAction
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloButton >> clickAction: aBlock [
	clickAction := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloButton >> color [
	^ cube color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloButton >> color: aColor [
	cube color: aColor
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloButton >> dragAction [
	^ dragAction
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloButton >> dragAction: aBlock [
	dragAction := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:45'
}
SRHaloButton >> dragTo: aMatrix4x4 [

	self dragAction ifNotNil: [:action | action cull: aMatrix4x4 cull: originalTransform ].
	super dragTo: aMatrix4x4
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloButton >> dropAction [
	^ dropAction
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloButton >> dropAction: anObject [
	dropAction := anObject
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:10'
}
SRHaloButton >> grabAction [
	^ grabAction
]

{
	#category : #actions,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:10'
}
SRHaloButton >> grabAction: anObject [
	grabAction := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:28'
}
SRHaloButton >> initialize [ 

	super initialize.
	
	cube := SRCube new
		"We want to handle all input events for our cube."
		cursorMode: SRCursorMode ignore;
		"We want to be grabbed ourselves."
		grabTarget: self;
		yourself.
	text := SRTextField new
		scale: 0.1 asVector3;
		position: 0@0@(6mm);
		centered: true.
	
	self addChildren: { cube. text }.
	self text: ''.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:31'
}
SRHaloButton >> minimumWidth [
	^ minimumWidth
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:34'
}
SRHaloButton >> minimumWidth: anObject [
	minimumWidth := anObject.
	self text: self text.
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:33'
}
SRHaloButton >> onButtonPress: event [

	event button = #trigger ifFalse: [^self].
	self clickAction ifNotNil: [:action | action cull: event. event handled: true.]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:36'
}
SRHaloButton >> onGrabStarted: aHand [

	originalTransform := self globalTransform.
	self grabAction ifNotNil: [:action | 
		action cull: aHand cull: self globalTransform
	]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloButton >> onGrabStopped: aHand [

	self globalTransform: originalTransform.
	self dropAction ifNotNil: [:action | action cull: aHand]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:18'
}
SRHaloButton >> text [

	^ text text
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:37'
}
SRHaloButton >> text: aString [

	| scale |
	text text: aString.
	scale := ((text textSize)@(1cm) * text scale) + (2 * self class padding).
	minimumWidth ifNotNil: [ 
		scale x: (scale x max: minimumWidth)
	].
	cube scale: scale
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:36'
}
SRHaloButton >> wantsGrab [
	^ self dragAction notNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 14:05'
}
SRHaloButton >> width [
	^cube scale x
]
