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
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRay >> castAll: anSRObject [

	| intersections |
	intersections := OrderedCollection new.
	anSRObject allDo: [:object |
		(self intersectionWith: object) ifNotNil: [:result | intersections add: result]].
	^ self sortedByDistance: intersections
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRay >> castAllObjects: aCollectionOfSRObjects [

	^ self sortedByDistance: (aCollectionOfSRObjects
		collect: [:object | self intersectionWith: object]
		thenSelect: [:result | result notNil])
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRay >> castNearest: anSRObject [

	^ (self castAll: anSRObject)
		ifEmpty: [nil]
		ifNotEmpty: [:results | results first]
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
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

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRay >> intersectionWith: anSRObject [

	^ anSRObject safeCollisionGeometry ifNotNil: [:geometry | geometry rayIntersection: self]
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

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:07'
}
SRRay >> sortedByDistance: intersections [

	^ intersections sorted: [:intersectionA :intersectionB |
		(self origin distanceTo: intersectionA point) < (self origin distanceTo: intersectionB point)]
]
