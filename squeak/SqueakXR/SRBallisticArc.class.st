"
The thrown-ball curve a teleport is aimed along. An SRRay is a straight line of infinite length and cannot express it, so the arc is walked as short segments, each one cast as a bounded ray.

Why an arc rather than a straight ray: the curve falls, so pointing a little downward reaches a near spot and pointing up reaches a far one, and the player can aim over the edge of a cliff at the ground below. The range is bounded by the speed rather than by an arbitrary cutoff.
"
Class {
	#name : #SRBallisticArc,
	#superclass : #Object,
	#instVars : [
		'origin',
		'direction',
		'speed',
		'gravity',
		'stepSeconds',
		'maxSteps',
		'points',
		'hit'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #casting,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArc >> castIn: aRootObject [

	| velocity from |
	points := OrderedCollection with: origin.
	hit := nil.
	velocity := direction safelyNormalized * speed.
	from := origin.
	maxSteps timesRepeat: [
		| to |
		to := from + (velocity * stepSeconds).
		(self firstHitFrom: from to: to in: aRootObject) ifNotNil: [:result |
			points add: result point.
			hit := result.
			^ self].
		points add: to.
		velocity := velocity - (Vector3 up * (gravity * stepSeconds)).
		from := to].
	^ self
]

{
	#category : #casting,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArc >> firstHitFrom: from to: to in: aRootObject [

	| segment ray result |
	segment := to - from.
	segment length < 1.0e-6 ifTrue: [^ nil].
	ray := SRRay origin: from forward: segment normalized.
	result := ray castNearestSolid: aRootObject.
	result ifNil: [^ nil].
	^ (from distanceTo: result point) <= segment length
		ifTrue: [result]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArc >> hit [

	^ hit
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArc >> initialize [
	super initialize.
	origin := Vector3 zero.
	direction := Vector3 forward.
	speed := 10.0.
	gravity := 9.81.

	stepSeconds := 0.1.
	maxSteps := 30.
	points := OrderedCollection new.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:37'
}
SRBallisticArc >> origin: aPoint direction: aVector [
	origin := aPoint.
	direction := aVector.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:38'
}
SRBallisticArc >> points [
	^ points
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:38'
}
SRBallisticArc >> speed: aNumber [
	speed := aNumber
]
