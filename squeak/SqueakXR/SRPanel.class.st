"
A flat object read from its front, like a window: its #forward is the side you look at. Grabbing moves it; releasing turns it, animated, to face the camera.
"
Class {
	#name : #SRPanel,
	#superclass : #SRObject,
	#instVars : [
		'alignmentTween'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel class >> alignedCosine [

	^ 0.05 degreesToRadians cos
]

{
	#category : #constants,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel class >> alignmentDuration [

	^ 400 milliSeconds
]

{
	#category : #constants,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel class >> cylinderHeight [

	^ 75cm
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> alignToCamera [

	self world ifNotNil: [:aWorld | self alignTowards: aWorld camera globalTranslation]
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> alignTowards: aPoint [

	| delta target |
	delta := self globalRotation inverse * (self alignedRotationFor: aPoint).
	delta a abs >= self class alignedCosine ifTrue: [^ self].
	target := self grabTarget.
	self alignmentTween
		from: target globalRotation to: target globalRotation * delta;
		target: (MessageSend receiver: target selector: #globalRotation:);
		start
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> alignedRotationFor: aPoint [

	^ (self isNearCameraHeight: aPoint)
		ifTrue: [self rotationFacingAxisThrough: aPoint]
		ifFalse: [self rotationFacing: aPoint]
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> alignmentTween [
	^ alignmentTween ifNil: [alignmentTween := self newAlignmentTween]
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> isNearCameraHeight: aPoint [

	^ ((self globalTranslation - aPoint) dot: Vector3 up) abs <= self class cylinderHeight
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> newAlignmentTween [
	| tween |
	tween := SRTween new
		duration: self class alignmentDuration;
		transitionCubic;
		easeOut;
		yourself.
	self addChild: tween.
	^ tween
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> onGrabStarted: aHand [
	super onGrabStarted: aHand.
	self stopAligning.
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> onGrabStopped: aHand [
	super onGrabStopped: aHand.
	self alignToCamera.
]

{
	#category : #aligning,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> stopAligning [
	alignmentTween ifNotNil: [:tween | tween stop]
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:44'
}
SRPanel >> wantsGrab [
	^ true
]
