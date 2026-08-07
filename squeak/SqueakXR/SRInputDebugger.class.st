Class {
	#name : #SRInputDebugger,
	#superclass : #SRObject,
	#instVars : [
		'tip',
		'trigger',
		'grip',
		'a',
		'b',
		'touch'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 16:04'
}
SRInputDebugger >> color: aColor [
	tip color: aColor.
	trigger color: aColor.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 15:38'
}
SRInputDebugger >> hand [
	^ self parent ifNotNil: [ :parent |
		(parent isKindOf: SRHand) ifTrue: [ parent ] ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 15:57'
}
SRInputDebugger >> initialize [ 
	super initialize.
	tip := SRCube new scale: 10cm asVector3.
	trigger := SRCube new scale: 10cm asVector3.

	self addChild: tip.
	self addChild: trigger.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 16:00'
}
SRInputDebugger >> step: deltaTime [ 
	| joy trig |
	joy := self hand joystick.
	trig := self hand trigger.

	tip position: joy vector.
	trigger position: 0@(trig value)@0.
]
