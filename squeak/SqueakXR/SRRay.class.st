Class {
	#name : #SRRay,
	#superclass : #Object,
	#instVars : [
		'origin',
		'forward'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #'as yet unclassified' }
SRRay class >> origin: aVector3 forward: anotherVector3 [

	^ self new
		origin: aVector3;
		forward: anotherVector3
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 10/6/2025 16:40'
}
SRRay >> cast: aSRWorld [

	^ self castAll: aSRWorld
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 7/3/2026 17:22'
}
SRRay >> castAll: aSRWorld [

	^ self castAllObjects: aSRWorld allDescendants
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 7/3/2026 17:22'
}
SRRay >> castAllObjects: aCollectionOfSRObjects [

	| intersections |
	intersections := OrderedCollection new.
	aCollectionOfSRObjects do: [:object |
		object collisionGeometryDo: [:geometry |
			(geometry rayIntersection: self) ifNotNil: [:result |
				intersections add: result]]].
	^ intersections sorted: [:intersectionA :intersectionB | | distA distB |
		distA := self origin distanceTo: intersectionA point.
		distB := self origin distanceTo: intersectionB point.
		distA < distB]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 7/3/2026 17:24'
}
SRRay >> castNearest: aSRWorld [

	^ self castNearestObjects: aSRWorld allDescendants
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 7/3/2026 17:24'
}
SRRay >> castNearestObjects: aCollectionOfSRObjects [

	^ (self castAllObjects: aCollectionOfSRObjects)
		ifEmpty: [nil]
		ifNotEmpty: [:results | results first]
]

{ #category : #accessing }
SRRay >> forward [

	^ forward
]

{ #category : #accessing }
SRRay >> forward: aVector3 [

	"must be normalized"
	forward := aVector3
]

{ #category : #accessing }
SRRay >> origin [

	^ origin
]

{ #category : #accessing }
SRRay >> origin: aVector3 [

	origin := aVector3
]

{ #category : #raycast }
SRRay >> project: aNumber [

	^ self origin + (self forward * aNumber)
]
