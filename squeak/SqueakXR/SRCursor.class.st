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
		'grabbedRelativeTransform'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 9/14/2026 14:55'
}

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
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:07'
}
SRCursor >> hand: anSRHand [
	
	(hand = anSRHand) ifTrue: [ ^ self ].
	hand ifNotNil: [:h | h removeDependent: self ].
	hand := anSRHand.
	hand ifNotNil: [:h | h addDependent: self ].
	hand cursor: self.

]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:17'
}
SRCursor >> initialize [ 

	super initialize .
	pointCube := (SRCube new
		scale: 1cm asVector3;
		color: Color red
	).
	self addChild: pointCube.
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
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:03'
}
SRCursor >> onAnalogInput: anAnalogEvent [

	anAnalogEvent handled ifTrue: [ ^ self ].
	self targetDo: [:target | 
		anAnalogEvent setFrom: self.
		target handleInput: anAnalogEvent
	]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 14:11'
}
SRCursor >> onButtonInput: aButtonEvent [

	aButtonEvent handled ifTrue: [ ^ self ].
	aButtonEvent button = #squeeze ifTrue: [
		aButtonEvent pressed 
		ifTrue: [ self startGrabbing ]
		ifFalse: [ self stopGrabbing ].
		aButtonEvent handled: true.
		^ self
	].
	self targetDo: [:target | 
		aButtonEvent setFrom: self.
		target handleInput: aButtonEvent
	]
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
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/16/2026 15:48'
}
SRCursor >> renderOn: aRenderer [

	"grabbedObject ifNotNil: [:grabbed | 
		grabbed collisionGeometryDo: [:col | col renderOn: aRenderer ]
	]"
]

{
	#category : #grabbing,
	#'squeak_changestamp' : 'phkeese 9/16/2026 16:21'
}
SRCursor >> startGrabbing [
	
	self targetDo: [:target |
		grabbedObject := target.
		grabbedRelativeTransform := self grabTransformBase inverseTransformation * grabbedObject globalTransform.
		grabbedObject startGrabbing: self hand.
	]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 9/16/2026 15:49'
}
SRCursor >> step: deltaTime [ 

	"| painter |
	grabbedObject ifNotNil: [
		painter := self gizmoPainter.
		painter ifNotNil: [
			grabbedObject collisionGeometryDo: [:geom |
				geom isCollisionBox ifTrue: [
					painter gizmoWireBox: geom color: Color green].
				geom isCollisionPlane ifTrue: [
					painter gizmoWirePlane: geom color: Color green]]]]."
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
	#'squeak_changestamp' : 'phkeese 9/15/2026 17:33'
}
SRCursor >> targetsIn: aWorld [
	
	"Find objects in aWorld which want a cursor"
	^ self world allDescendantsSelect: [ :object | object wantsCursor ]
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 15:49'
}
SRCursor >> update: anAspect [

	anAspect = #actionsUpdated ifTrue: [ self 
		onActionsUpdated;
		updateVisuals;
		updateGrabbedObjectTransform.
		
		grabbedObject ifNotNil: [ | painter |
			painter := self gizmoPainter.
			painter ifNotNil: [
				grabbedObject collisionGeometryDo: [:geom |
					geom isCollisionBox ifTrue: [
						painter gizmoWireBox: geom color: Color green].
					geom isCollisionPlane ifTrue: [
						painter gizmoWirePlane: geom color: Color green]]]].
	].
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:04'
}
SRCursor >> update: anAspect with: anObject [

	"
	By default, we pass any unhandled input events along to our current target.
	See on{Button,Analog}Input: 
	"
	anAspect = #buttonInput ifTrue: [ self onButtonInput: anObject ].
	anAspect = #analogInput ifTrue: [ self onAnalogInput: anObject ].
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
	#'squeak_changestamp' : 'phkeese 9/16/2026 11:29'
}
SRCursor >> updateVisuals [

	"
	Method for updating the cursor's own visuals, called after onActionsUpdated.
	By default, this moves the cursor's hit cube to the current point or hides it if not aiming at anything.
	Subclasses should call this method in their overrides.
	"
	self point 
		ifNotNil: [:point | 
			pointCube
				visible: true; 
				globalTranslation: point
		]
		ifNil: [ pointCube visible: false ]
]
