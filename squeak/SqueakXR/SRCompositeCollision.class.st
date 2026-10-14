Class {
	#name : #SRCompositeCollision,
	#superclass : #SRCollisionGeometry,
	#instVars : [
		'components'
	],
	#category : #'SqueakXR-Collisions'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:08'
}
SRCompositeCollision >> components [
	^ components
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:08'
}
SRCompositeCollision >> components: anObject [
	components := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:09'
}
SRCompositeCollision >> drawGizmoOn: aGizmoPainter colored: aColor [
	
	self components do: [:geom |
		geom drawGizmoOn: aGizmoPainter colored: aColor
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:08'
}
SRCompositeCollision >> initialize [ 

	super initialize.
	
	components := OrderedCollection new.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:35'
}
SRCompositeCollision >> performOnComponents: aMessageName with: aCollisionQuery [

	| allHits hit sortedHits trueHits |
	allHits := self components collect: [:geom |
		geom perform: aMessageName with: aCollisionQuery ].
	trueHits := allHits reject: [:x | x isNil ].
	sortedHits := trueHits sorted: [:a :b | a distance < b distance ].
	hit := sortedHits at: 1 ifAbsent: [ nil ].
	hit ifNotNil: [ hit object: self object ].
	^ hit
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:23'
}
SRCompositeCollision >> pointIntersection: aCollisionPoint [
	
	^ self performOnComponents: #pointIntersection: with: aCollisionPoint
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/14/2026 16:24'
}
SRCompositeCollision >> rayIntersection: aRay [

	^ self performOnComponents: #rayIntersection: with: aRay

]
