"
A SRHaloHandle is a handle to be placed on a halo.

Instance Variables
clickAction - Called whenever the button is clicked on.
dragAction 	- Called when the button is dragged by a cursor.
grabAction 	- Called when grabbing this handle.
dropAction 	- Called then releasing this handle.
"
Class {
	#name : #SRHaloHandle,
	#superclass : #SRObject,
	#instVars : [
		'clickAction',
		'dragAction',
		'dropAction',
		'cube',
		'text',
		'originalTransform',
		'grabAction'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:10'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:31'
}
SRHaloHandle class >> padding [

	^ (1cm)@(1cm)@(0)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:25'
}
SRHaloHandle >> clickAction [
	^ clickAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloHandle >> clickAction: aBlock [
	clickAction := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloHandle >> color [
	^ cube color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloHandle >> color: aColor [
	cube color: aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloHandle >> dragAction [
	^ dragAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:26'
}
SRHaloHandle >> dragAction: aBlock [
	dragAction := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:45'
}
SRHaloHandle >> dragTo: aMatrix4x4 [

	self dragAction ifNotNil: [:action | action cull: aMatrix4x4 cull: originalTransform ].
	super dragTo: aMatrix4x4
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloHandle >> dropAction [
	^ dropAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloHandle >> dropAction: anObject [
	dropAction := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:10'
}
SRHaloHandle >> grabAction [
	^ grabAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:10'
}
SRHaloHandle >> grabAction: anObject [
	grabAction := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:28'
}
SRHaloHandle >> initialize [ 

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
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:33'
}
SRHaloHandle >> onButtonPress: event [

	event button = #trigger ifFalse: [^self].
	self clickAction ifNotNil: [:action | action cull: event. event handled: true.]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:36'
}
SRHaloHandle >> onGrabStarted: aHand [

	originalTransform := self globalTransform.
	self grabAction ifNotNil: [:action | 
		action cull: aHand cull: self globalTransform
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:11'
}
SRHaloHandle >> onGrabStopped: aHand [

	self globalTransform: originalTransform.
	self dropAction ifNotNil: [:action | action cull: aHand]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:18'
}
SRHaloHandle >> text [

	^ text text
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:31'
}
SRHaloHandle >> text: aString [

	text text: aString.
	cube scale: ((text textSize)@(1cm) * text scale) + (2 * self class padding)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/21/2026 15:36'
}
SRHaloHandle >> wantsGrab [
	^ self dragAction notNil
]
