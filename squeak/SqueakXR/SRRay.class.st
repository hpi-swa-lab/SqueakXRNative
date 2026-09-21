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
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> allIntersectionsIn: anEnumerationBlock [
	"anEnumerationBlock takes a one-argument block and feeds it every candidate object."

	| intersections |
	intersections := OrderedCollection new.
	anEnumerationBlock value: [:object |
		(self intersectionWith: object) ifNotNil: [:result |
			intersections add: result]].
	^ intersections sorted: [:intersectionA :intersectionB |
		(self origin distanceTo: intersectionA point) < (self origin distanceTo: intersectionB point)]
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
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> castAll: anSRObject [

	^ self allIntersectionsIn: [:aBlock | anSRObject allDo: aBlock]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> castAllObjects: aCollectionOfSRObjects [

	^ self allIntersectionsIn: [:aBlock | aCollectionOfSRObjects do: aBlock]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> castNearest: anSRObject [

	^ self nearestIntersectionIn: [:aBlock | anSRObject allDo: aBlock]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> castNearestObjects: aCollectionOfSRObjects [

	^ self nearestIntersectionIn: [:aBlock | aCollectionOfSRObjects do: aBlock]
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

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:09'
}
SRRay >> intersectionWith: anSRObject [

	"Not #collisionGeometryDo: -- a non-inlined block argument costs a closure per
	object, and this runs over the whole tree on every raycast."

	^ anSRObject collisionGeometry ifNotNil: [:geometry | geometry rayIntersection: self]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 16:06'
}
SRRay >> nearestIntersectionIn: anEnumerationBlock [
	"anEnumerationBlock takes a one-argument block and feeds it every candidate object."

	| nearest nearestDistance |
	nearestDistance := Float infinity.
	anEnumerationBlock value: [:object |
		(self intersectionWith: object) ifNotNil: [:result |
			| distance |
			distance := self origin distanceTo: result point.
			distance < nearestDistance ifTrue: [
				nearestDistance := distance.
				nearest := result]]].
	^ nearest
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
