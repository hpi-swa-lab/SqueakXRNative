Class {
	#name : #SRPointCursor,
	#superclass : #SRCursor,
	#instVars : [
		'sphere',
		'radius',
		'hit'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:29'
}
SRPointCursor >> initialize [ 

	super initialize.
	
	radius := 5cm.
	sphere := (SRSphere new
		scale: self radius asVector3 
	).
	self addChild: sphere.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:01'
}
SRPointCursor >> onActionsUpdated [ 

	self globalTranslation: self hand globalTranslation * 2.
	self 
		updateHover;
		updateSphere
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
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:54'
}
SRPointCursor >> radius: aFloat [

	radius := aFloat.
	sphere scale: aFloat asVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:02'
}
SRPointCursor >> target [

	^ hit ifNotNil: [:h | h object ]
]

{
	#category : #'as yet unclassified',
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

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/15/2026 18:01'
}
SRPointCursor >> updateSphere [ 
]
