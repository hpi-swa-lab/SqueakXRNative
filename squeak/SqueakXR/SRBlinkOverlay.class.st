"
Fades the view to black, performs an action while nothing can be seen, and fades back. The other half of why a teleport does not make people sick: moving the world under an open eye is the part the inner ear objects to, so the eye is shut for it.

A child of the camera, one panel a handspan in front of the face, which covers both eyes because the stereo offset is applied below it.
"
Class {
	#name : #SRBlinkOverlay,
	#superclass : #SRObject,
	#instVars : [
		'panel',
		'phase',
		'elapsed',
		'pendingAction'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRBlinkOverlay class >> fadeInSeconds [
	"Longer than the fade out: arriving gently reads as having arrived, where a
	hard cut reads as a glitch."

	^ 0.18
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:56'
}
SRBlinkOverlay class >> fadeOutSeconds [
	"Short: this is time between asking to go and going."

	^ 0.08
]

{
	#category : #blinking,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRBlinkOverlay >> blinkThen: aBlock [
	"A second blink while one is running would strand the action of the first,
	so the running one is finished immediately rather than dropped."

	phase == #idle ifFalse: [self runPendingAction].
	pendingAction := aBlock.
	phase := #out.
	elapsed := 0.0.
	panel visible: true.
	self opacity: 0.0
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:56'
}
SRBlinkOverlay >> initialize [
	super initialize.
	"Four metres across at 20 cm from the eye: wider than any field of view, and
	beyond the near clipping plane."
	panel := SRFastCube new
		scale: 4 @ 4 @ 0.01;
		position: 0 @ 0 @ 20 cm;
		color: Color black;
		visible: false;
		yourself.
	self addChild: panel.
	phase := #idle.
	elapsed := 0.0.
]

{
	#category : #blinking,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:58'
}
SRBlinkOverlay >> isBlinking [
	^ phase ~~ #idle
]

{
	#category : #blinking,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:58'
}
SRBlinkOverlay >> opacity [
	^ panel color alpha
]

{
	#category : #blinking,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRBlinkOverlay >> opacity: aFraction [
	panel color: (Color black alpha: ((aFraction max: 0.0) min: 1.0))
]

{
	#category : #blinking,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRBlinkOverlay >> runPendingAction [
	pendingAction ifNotNil: [:block |
		pendingAction := nil.
		block value]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:57'
}
SRBlinkOverlay >> step: deltaTime [
	| seconds |
	phase == #idle ifTrue: [^ self].
	seconds := deltaTime / 1000.0.
	elapsed := elapsed + seconds.
	phase == #out ifTrue: [
		elapsed < self class fadeOutSeconds
			ifTrue: [^ self opacity: elapsed / self class fadeOutSeconds].
		self opacity: 1.0.
		"Behind a black screen, which is the whole point of the exercise."
		self runPendingAction.
		phase := #in.
		elapsed := 0.0.
		^ self].
	elapsed < self class fadeInSeconds
		ifTrue: [^ self opacity: 1.0 - (elapsed / self class fadeInSeconds)].
	self opacity: 0.0.
	panel visible: false.
	phase := #idle.
]
