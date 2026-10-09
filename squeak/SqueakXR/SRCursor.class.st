"
A SRCursor is an abstract input handler for an SRHand. It receives trigger, grip & face button inputs and selects objects in the world.

Instance Variables
hand - SRHand this cursor belongs to
"
Class {
	#name : #SRCursor,
	#superclass : #SRObject,
	#instVars : [
		'hand',
		'pointCube',
		'grabbedObject',
		'grabbedRelativeTransform',
		'label'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 9/14/2026 14:55'
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
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/9/2026 12:55'
}
SRCursor >> forwardAnalogInput: anAnalogEvent [

	anAnalogEvent handled ifTrue: [ ^ self ].
	self targetDo: [:target | 
		anAnalogEvent setFrom: self.
		target handleInput: anAnalogEvent
	]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/9/2026 12:55'
}
SRCursor >> forwardButtonInput: aButtonEvent [

	aButtonEvent handled ifTrue: [ ^ self ].
	
	"Grab objects with the squeeze button".
	aButtonEvent button = #squeeze ifTrue: [
		aButtonEvent pressed 
		ifTrue: [ self startGrabbing ]
		ifFalse: [ self stopGrabbing ].
		aButtonEvent handled: true.
		^ self
	].
	
	"Ignore input while grabbing something."
	self grabbedObject ifNotNil: [ 
		aButtonEvent handled: true.
		^ self
	].	

	"Forward any other events to the target"
	self targetDo: [:target | 
		aButtonEvent setFrom: self.
		target handleInput: aButtonEvent
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:17'
}
SRCursor >> grabTransformBase [ 

	^ self globalTransform
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:06'
}
SRCursor >> grabbedObject [ 

	^ grabbedObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:18'
}
SRCursor >> grabbedRelativeTransform [
	^ grabbedRelativeTransform
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:18'
}
SRCursor >> grabbedRelativeTransform: anObject [
	grabbedRelativeTransform := anObject
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
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:31'
}
SRCursor >> hand: anSRHand [
	
	| oldHand |
	(hand = anSRHand) ifTrue: [ ^ self ].
	oldHand := hand.
	hand ifNotNil: [ hand removeDependent: self ].
	hand := anSRHand.
	hand ifNotNil: [ hand addDependent: self ].
	self onHandChanged: oldHand
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/24/2026 15:25'
}
SRCursor >> highlightTarget [ 

	self targetDo: [:target | self haloState addOutlineFor: target colored: self color ]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 10/8/2026 17:57'
}
SRCursor >> initialize [ 

	super initialize.
	self cursorMode: SRCursorMode ignore.
	
	pointCube := (SRCube new
		scale: 1cm asVector3;
		color: Color red
	).
	self addChild: pointCube.
	
	label := SRTextField new
		text: self class name asString;
		color: self color;
		scale: 0.015 asVector3;
		rotation: (Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right);
		yourself.
	self addChild: label.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:53'
}
SRCursor >> label [
	
	label text
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:53'
}
SRCursor >> label: aValue [
	
	label text: aValue asString
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/30/2026 16:04'
}
SRCursor >> labelPosition [

	"Get the global position of our label"
	^ self globalTranslation
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:00'
}
SRCursor >> onActionsUpdated [

	"
	Called when my hand's actions have been updated but before it emits input events.
	Useful for performing e.g. raycasts and update targeting.
	"
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/30/2026 16:44'
}
SRCursor >> onHandChanged: oldHand [

	"
	Called when we change our hand. 
	Children should call this in their own impls to automatically handle grabbing and releasing.
	"
	oldHand ifNotNil: [ self stopGrabbing ].
	pointCube color: self color.
	label color: self color.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:29'
}
SRCursor >> point [
	
	"Hit position in the world, if it exists."
	^ self subclassResponsibility 
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'phkeese 10/1/2026 13:47'
}
SRCursor >> startGrabbing [
	
	self targetDo: [:target |
		target canGrab ifFalse: [^self].
		grabbedObject := target.
		grabbedRelativeTransform := self grabTransformBase inverseTransformation * grabbedObject globalTransform.
		grabbedObject startGrabbing: self hand.
	]
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:05'
}
SRCursor >> stopGrabbing [ 
	
	grabbedObject ifNotNil: [ grabbedObject stopGrabbing: self hand ].
	grabbedObject := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:29'
}
SRCursor >> target [
	
	"Object I am pointing at, if it exists."
	^ self subclassResponsibility 
]

{
	#category : #'apply primitives',
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:14'
}
SRCursor >> targetDo: aBlock [
	^ self target ifNotNil: [:target | aBlock value: target ]
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
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:52'
}
SRCursor >> update: anAspect [

	anAspect = #actionsUpdated ifTrue: [ self 
		onActionsUpdated;
		updateGrabbedObjectTransform;
		updateHitPoint;
		highlightTarget;
		updateLabel
	].
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 10/9/2026 12:51'
}
SRCursor >> update: anAspect with: anObject [

	"
	By default, we pass any unhandled input events along to our current target, as long as we are not grabbing something.
	See on{Button,Analog}Input: 
	"
	anAspect = #buttonInput ifTrue: [ self forwardButtonInput: anObject ].
	anAspect = #analogInput ifTrue: [ self forwardAnalogInput: anObject ].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:18'
}
SRCursor >> updateGrabbedObjectTransform [ 

	grabbedObject ifNotNil: [
		grabbedObject dragTo: self grabTransformBase * grabbedRelativeTransform
	]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/30/2026 15:35'
}
SRCursor >> updateHitPoint [

	self point 
		ifNotNil: [:point | 
			pointCube
				visible: true; 
				globalTranslation: point.
			self gizmoPainter gizmoObject: pointCube.
		]
		ifNil: [ pointCube visible: false ]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/30/2026 16:09'
}
SRCursor >> updateLabel [

	label globalTranslation: self labelPosition.
]
