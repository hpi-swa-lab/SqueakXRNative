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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:37'
}
SRBallisticArc >> castIn: aRootObject [
	"Walk the curve segment by segment, casting each as a bounded ray. Stops at
	the first thing hit, so #points is the drawable part of the arc and #hit is
	the landing place, or nil when the curve ran out of steps."

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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:35'
}
SRBallisticArc >> firstHitFrom: from to: to in: aRootObject [
	"An SRRay is infinite, so a hit beyond the end of this segment belongs to a
	later one and must be rejected here."

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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:38'
}
SRBallisticArc >> hit [
	"The SRRayIntersectionResult the curve ran into, or nil when it ran out of
	steps first: an arc that reached nothing is not a place to stand."

	^ hit
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:40'
}
SRBallisticArc >> initialize [
	super initialize.
	origin := Vector3 zero.
	direction := Vector3 forward.
	speed := 10.0.
	gravity := 9.81.
	"One cast per segment, so the step is what the preview costs per frame. A
	segment is a ray and cannot tunnel along its own length; the only error is
	the chord cutting the corner, which at 0.1 s is under 5 cm. Thirty of them
	is three seconds of flight, enough to complete an arc thrown upward."
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
