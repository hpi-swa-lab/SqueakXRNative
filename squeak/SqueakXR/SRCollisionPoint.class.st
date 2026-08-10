"
A SRCollisionPoint is a collision query at a specific point.

Instance Variables

"
Class {
	#name : #SRCollisionPoint,
	#superclass : #Object,
	#instVars : [
		'origin'
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
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:56'
}
SRCollisionPoint >> castAllObjects: aCollectionOfSRObjects [
	| intersections |
	intersections := OrderedCollection new.
	aCollectionOfSRObjects do: [:object |
		object collisionGeometryDo: [:geometry |
			(geometry contains: self origin)
				ifTrue: [intersections add: object]
		]
	].
	^ intersections
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
