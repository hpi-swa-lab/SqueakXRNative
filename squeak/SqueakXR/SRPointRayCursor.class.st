Class {
	#name : #SRPointRayCursor,
	#superclass : #SRCursor,
	#instVars : [
		'gogo',
		'raycube',
		'hit'
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
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:27'
}
SRPointRayCursor >> castCollision [
	"Cast ray into scene but filter out any objects that don't want a cursor"

	| ray targets point |
	self world ifNil: [ ^ nil ].
	targets := grabbedObject ifNotNil: [{ grabbedObject }] ifNil: (self targetsIn: self world).
	point := SRCollisionPoint new
		origin: gogo globalTranslation;
		radius: self class grabRadius.
	(point castAllObjects: targets) ifNotEmpty: [:results | ^ results first ].
		
	ray := SRRay origin: gogo globalTranslation forward: gogo backward.
	^ (ray castAllObjects: targets) ifEmpty: [ nil ] ifNotEmpty: [ :results | results first ]
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
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:06'
}
SRPointRayCursor >> initialize [ 

	super initialize.
	
	gogo := SRGoGoExtender new.
	raycube := SRCube new
		color: (Color red alpha: 0.5).
	gogo addChild: raycube.
	self addChild: gogo.
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:09'
}
SRPointRayCursor >> onActionsUpdated [ 

	self
		updateGoGo;
		updateHover;
		updateLaser.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:33'
}
SRPointRayCursor >> onHandChanged: oldHand [

	raycube color: (self color alpha: 0.5).
	^ super onHandChanged: oldHand.
	
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
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:25'
}
SRPointRayCursor >> updateHover [

	| newHit newTarget oldTarget |
	newHit := self castCollision.
	oldTarget := self target.
	newTarget := newHit ifNotNil: [ newHit object ].

	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target handleInput: (SRInputEventCursorLeave new setFrom: self)].
	].
	
	hit := newHit.
	
	(oldTarget ~= newTarget) ifTrue: [
		self targetDo: [:target | target handleInput: (SRInputEventCursorEnter new setFrom: self)].
	].

	self targetDo: [:target | target handleInput: (SRInputEventCursorMove new setFrom: self)].

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 15:09'
}
SRPointRayCursor >> updateLaser [

	| length width |
	width := self class laserWidth.
	length := (self point 
		ifNotNil: [:point | point distanceTo: gogo globalTranslation ]
		ifNil: [ 10 ]).
	raycube 
		scale: width @ width @ length;
		translation: 0 @ 0 @ (length negated / 2).
]
