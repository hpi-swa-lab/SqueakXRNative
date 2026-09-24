Class {
	#name : #SRPointCursor,
	#superclass : #SRCursor,
	#instVars : [
		'approachRadius',
		'radius',
		'hit',
		'gogo',
		'approached'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 13:14'
}
SRPointCursor >> approachRadius [
	^ approachRadius
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 13:14'
}
SRPointCursor >> approachRadius: anObject [
	approachRadius := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/24/2026 14:34'
}
SRPointCursor >> approachStrengthAt: aDistance [

	^ 1 - (aDistance / self approachRadius)
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/24/2026 13:15'
}
SRPointCursor >> findApproached [

	"Find objects this cursor is currently approaching"
	| targets point |
	self world ifNil: [ ^ nil ].
	targets := self targetsIn: self world.
	point := SRCollisionPoint new
		origin: gogo globalTranslation;
		radius: self approachRadius.
	^ point castAllObjects: targets
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:20'
}
SRPointCursor >> grabTransformBase [ 

	^ gogo globalTransform
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 9/24/2026 13:36'
}
SRPointCursor >> initialize [ 

	super initialize.
	
	radius := 5cm.
	approachRadius := 1m.
	gogo := SRGoGoExtender new.
	self addChild: gogo.
	approached := OrderedCollection new.
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/17/2026 14:31'
}
SRPointCursor >> onActionsUpdated [ 

	self updateHover.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:02'
}
SRPointCursor >> point [

	^ hit ifNotNil: [ :h | h point ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:29'
}
SRPointCursor >> radius [
	^ radius
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:50'
}
SRPointCursor >> radius: aFloat [

	radius := aFloat
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:12'
}
SRPointCursor >> renderInSecondPass [ 

	^ true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:15'
}
SRPointCursor >> renderOn: aRenderer [

	| xform local |
	super renderOn: aRenderer.
	
	local := Matrix4x4 identity scaledBy: self radius * 2 asVector3.
	xform := gogo globalTransform * local.
	aRenderer renderWireSphereTransformed: xform withColor: self color.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:24'
}
SRPointCursor >> step: deltaTime [ 

	self world isXR not ifTrue: [ self updateHover ].
	approached do: [:hit | | color t |
		t := self approachStrengthAt: hit distance.
		color := self color darker alphaMixed: t with: Color transparent.
		self haloState addOutlineFor: hit object colored: color
	].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:02'
}
SRPointCursor >> target [

	^ hit ifNotNil: [:h | h object ]
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/24/2026 13:41'
}
SRPointCursor >> updateHover [ 

	"Update the closest object"
	| newHit newTarget oldTarget inRange |
	approached := self findApproached.
	inRange := approached select: [:aHit | aHit distance < self radius ].
	
	newHit := inRange ifEmpty: nil ifNotEmpty: [ inRange first ].
	
	oldTarget := self target.
	newTarget := newTarget ifNotNil: [:h | h object ].
	
	(oldTarget ~= newTarget) ifTrue: [ 
		self targetDo: [:target | target handleInput: (SRInputEventCursorLeave new setFrom: self)].
	].

	hit := newHit.
	
	(oldTarget ~= newTarget) ifTrue: [ 
		self targetDo: [:target | target handleInput: (SRInputEventCursorEnter new setFrom: self)].
	].
	
	self targetDo: [:target | target handleInput: (SRInputEventCursorMove new setFrom: self)].
]
