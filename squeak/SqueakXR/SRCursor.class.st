"
A SRCursor is an abstract way of ""finding something"" in the world.

Instance Variables
hand - SRHand this cursor belongs to
"
Class {
	#name : #SRCursor,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'focusPoint',
		'focusCube'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:01'
}

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese 10/5/2026 15:26'
}
SRCursor >> castRayOn: targets from: anOrigin toward: aDirection [
	
	"
	Casts a ray among the specified objects and returns a hit.
	Subclasses should use this unless they need special collision handling.
	Returns a list of all objects along the ray, sorted by their distance from the origin.
	"
	| ray |
	ray := SRRay origin: anOrigin forward: aDirection.
	^ (ray castAllObjects: targets asOrderedCollection)
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese 10/5/2026 16:53'
}
SRCursor >> castSphereOn: targets from: anOrigin radius: aNumber [
	
	"
	Casts a sphere among the specified objects and returns a list of hits, 
	sorted by their distance to the origin.
	Subclasses should use this unless they need special collision handling.
	"
	| point |
	point := SRCollisionPoint new
		origin: anOrigin;
		radius: aNumber.
	^ point castAllObjects: targets asOrderedCollection
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:16'
}
SRCursor >> color [

	^ self hand ifNotNil: [:hand | hand color ] ifNil: [ Color black ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:16'
}
SRCursor >> firstIntersection [ 

	"Answer the first intersection, if it exists."
	^ self intersections
		ifNotEmpty: [:inter | inter first ] 
		ifEmpty: [ nil ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:40'
}
SRCursor >> focusPoint [
	^ focusPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:42'
}
SRCursor >> focusPoint: aPoint [

	focusPoint := aPoint.
	aPoint ifNil: [
		focusCube visible: false
	] ifNotNil: [
		focusCube globalTranslation: aPoint.
		focusCube visible: true.
	]
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'phkeese 10/19/2026 16:25'
}
SRCursor >> grabbingTransform [ 

	^ self globalTransform
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 10:57'
}
SRCursor >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:34'
}
SRCursor >> hand: anSRHand [
	
	hand := anSRHand
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 10/19/2026 15:05'
}
SRCursor >> initialize [ 

	super initialize.
	self cursorMode: SRCursorMode ignore.
	
	focusCube := (SRCube new
		scale: 1cm asVector3;
		cursorMode: SRCursorMode ignore
	).
	self addChild: focusCube.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:06'
}
SRCursor >> intersections [
	
	"Answer a sorted list of intersections, usually by their distance.
	The first element should be the 'front' or 'most important' object."
	^ self subclassResponsibility
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:06'
}
SRCursor >> intersectionsSelect: aBlock [
	
	"Filter the list of our intersections and keep only the ones where aBlock value: anIntersection returns true."
	^ self intersections select: aBlock
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:41'
}
SRCursor >> targetsIn: aSubTree [
	
	"Find all objects in a subtree which want a cursor."
	^ aSubTree allDescendantsSelect: [:object |
		object wantsCursor 
	]
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:41'
}
SRCursor >> targetsInWorld [
	
	"Find all objects in my world which want a cursor."
	^ self world
		ifNil: [ {} ]
		ifNotNil: [:world | self targetsIn: world ]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:34'
}
SRCursor >> updateActions: actionState [
	
	"Called when my hand's actions have been updated.
	Useful for performing e.g. raycasts and update targeting."
]
