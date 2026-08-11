"
A SRCollisionPoint is a collision query at a specific point.

Instance Variables

"
Class {
	#name : #SRCollisionPoint,
	#superclass : #Object,
	#instVars : [
		'origin',
		'radius'
	],
	#category : #'SqueakXR-Collisions',
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:48'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:49'
}
SRCollisionPoint >> cast: aSRWorld [
	^ self castAll: aSRWorld
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:50'
}
SRCollisionPoint >> castAll: aSRWorld [

	^ self castAllObjects: aSRWorld allDescendants
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 14:37'
}
SRCollisionPoint >> castAllObjects: aCollectionOfSRObjects [
	| intersections |
	intersections := OrderedCollection new.
	aCollectionOfSRObjects do: [:object |
		object collisionGeometryDo: [:geometry |
			((geometry distanceTo: self origin) < self radius) 
				ifTrue: [intersections add: object]
		]
	].
	^ intersections
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 10:59'
}
SRCollisionPoint >> initialize [
	origin := Vector3 zero.
	radius := 0.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:49'
}
SRCollisionPoint >> origin [
	^ origin
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:49'
}
SRCollisionPoint >> origin: anObject [
	origin := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 10:59'
}
SRCollisionPoint >> radius [
	^ radius
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 10:59'
}
SRCollisionPoint >> radius: anObject [
	radius := anObject
]
