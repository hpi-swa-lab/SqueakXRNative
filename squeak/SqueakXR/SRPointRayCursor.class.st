Class {
	#name : #SRPointRayCursor,
	#superclass : #SRCursor,
	#instVars : [
		'gogo',
		'intersections'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:21'
}
SRPointRayCursor class >> grabRadius [
	^5cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:08'
}
SRPointRayCursor class >> laserWidth [ 
	 ^ 0.5cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:15'
}
SRPointRayCursor >> castCollision [
	
	"Cast ray into scene but filter out any objects that don't want a cursor"
	
	^ self castCollisionOn: self targetsInWorld
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:35'
}
SRPointRayCursor >> castCollisionOn: targets [

	"Prefer collisions with our sphere over raycast."
	(self 
		castSphereOn: targets 
		from: gogo globalTranslation 
		radius: self class grabRadius
	) ifNotEmpty: [:results | ^ results first ].
	
	"...then try and find something along the ray"
	^ (self castRayOn: targets from: gogo globalTranslation toward: gogo backward)
		ifEmpty: [ nil ] ifNotEmpty: [:r | r first ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:38'
}
SRPointRayCursor >> castCollisionOn: firstList then: secondList [

	^ (self castCollisionOn: firstList)
		ifNil: [ self castCollisionOn: secondList ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:18'
}
SRPointRayCursor >> grabTransformBase [ 
	^ gogo globalTransform
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:29'
}
SRPointRayCursor >> initialize [ 

	super initialize.
	
	gogo := SRGoGoExtender new.
	self addChild: gogo.
	
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:23'
}
SRPointRayCursor >> intersections [ 

	^ intersections
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:18'
}
SRPointRayCursor >> onActionsUpdated [ 

	self 
		updateGoGo;
		updateIntersections.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:11'
}
SRPointRayCursor >> point [

	^ hit ifNotNil: [ hit point ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:20'
}
SRPointRayCursor >> renderInSecondPass [ 
	^true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:29'
}
SRPointRayCursor >> renderOn: aRenderer [
	| xform |
	xform := gogo globalTransform * (Matrix4x4 identity scaledBy: self class grabRadius * 2 asVector3).
	aRenderer renderWireSphereTransformed: xform withColor: self color.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:11'
}
SRPointRayCursor >> target [ 
	^ grabbedObject ifNil: [
		hit ifNotNil: [ hit object 
		]
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:09'
}
SRPointRayCursor >> updateGoGo [ 

	gogo updatePosition
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/19/2026 13:23'
}
SRPointRayCursor >> updateIntersections [ 

	| targets |
	targets := self targetsInWorld.
	intersections := OrderedCollection new.
	
	"Prefer objects inside the small sphere."
	intersections addAll: (
		self
			castSphereOn: targets
			from: gogo globalTranslation
			radius: self class grabRadius
	).
	
	"Then along the ray."
	intersections addAll: (
		self
			castRayOn: targets
			from: gogo globalTranslation 
			toward: gogo backward
	).
	
]
