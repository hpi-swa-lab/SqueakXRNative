"
Interpolates from one value to another over a duration while mounted in a world, sending each value to target with #value:.
"
Class {
	#name : #SRTween,
	#superclass : #SRObject,
	#instVars : [
		'duration',
		'elapsed',
		'transition',
		'ease',
		'from',
		'to',
		'target'
	],
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #playing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> currentValue [

	self isFinished ifTrue: [^ to].
	^ from interpolateTo: to at: (transition value: self progress ease: ease)
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTween >> duration [

	^ duration
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTween >> duration: aDuration [

	duration := aDuration
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> ease [

	^ ease
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> ease: anEaseSymbol [

	ease := anEaseSymbol
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> easeIn [

	self ease: #in
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> easeInOut [

	self ease: #inOut
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> easeOut [

	self ease: #out
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> easeOutIn [

	self ease: #outIn
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> from [

	^ from
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> from: aValue [

	from := aValue
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> from: aValue to: anotherValue [

	from := aValue.
	to := anotherValue
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTween >> initialize [

	super initialize.
	isStepping := false.
	elapsed := 0.
	duration := 1 seconds.
	transition := SRTransition linear.
	ease := #inOut
]

{
	#category : #playing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> isFinished [

	^ self progress >= 1
]

{
	#category : #playing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> progress [

	| seconds |
	seconds := duration asNanoSeconds / 1.0e9.
	seconds <= 0 ifTrue: [^ 1].
	^ elapsed / seconds min: 1
]

{
	#category : #playing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> start [

	elapsed := 0.
	isStepping := true
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> step: deltaTime [

	elapsed := elapsed + deltaTime.
	target value: self currentValue.
	self isFinished ifTrue: [self stop]
]

{
	#category : #playing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> stop [

	isStepping := false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> target [

	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> target: aValueReceiver [

	target := aValueReceiver
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> to [

	^ to
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> to: aValue [

	to := aValue
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRTween >> transition [

	^ transition
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:23'
}
SRTween >> transition: aTransition [

	transition := aTransition
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionBack [

	self transition: SRTransition back
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionBounce [

	self transition: SRTransition bounce
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionCirc [

	self transition: SRTransition circ
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionCubic [

	self transition: SRTransition cubic
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionElastic [

	self transition: SRTransition elastic
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionExpo [

	self transition: SRTransition expo
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionLinear [

	self transition: SRTransition linear
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionQuad [

	self transition: SRTransition quad
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionQuart [

	self transition: SRTransition quart
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionQuint [

	self transition: SRTransition quint
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionSine [

	self transition: SRTransition sine
]

{
	#category : #transitions,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 18:32'
}
SRTween >> transitionSpring [

	self transition: SRTransition spring
]
