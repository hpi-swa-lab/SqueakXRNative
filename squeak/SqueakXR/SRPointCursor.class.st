Class {
	#name : #SRPointCursor,
	#superclass : #SRCursor,
	#instVars : [
		'radius',
		'hit'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:36'
}
SRPointCursor >> findClosest [

	| targets point |
	self world ifNil: [ ^ nil ].
	targets := self targetsIn: self world.
	point := SRCollisionPoint new
		origin: self globalTranslation;
		radius: self radius.
	^ (point castAllObjects: targets) ifEmpty: [ nil ] ifNotEmpty: [ :results | results first ]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:50'
}
SRPointCursor >> initialize [ 

	super initialize.
	
	radius := 5cm.
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 15:00'
}
SRPointCursor >> onActionsUpdated [ 

	self 
		updateHover
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
	#'squeak_changestamp' : 'phkeese 9/16/2026 15:31'
}
SRPointCursor >> renderOn: aRenderer [

	| xform local |
	super renderOn: aRenderer.
	
	local := Matrix4x4 identity scaledBy: self radius * 2 asVector3.
	xform := self globalTransform * local.
	aRenderer renderWireSphereTransformed: xform withColor: Color black.
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
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:08'
}
SRPointCursor >> updateHover [ 

	"Update the closest object"
	| newHit newTarget oldTarget |
	oldTarget := self target.
	newHit := self findClosest.
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
