"
A SRHalo is xxxxxxxxx.

Instance Variables
	center:		<Object>
	hand:		<Object>
	target:		<Object>

center
	- position this halo is invoked at

hand
	- hand invoking this halo

target
	- target object

"
Class {
	#name : #SRHalo,
	#superclass : #SRObject,
	#instVars : [
		'target',
		'targetLocalPoint',
		'frozen'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:38'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:05'
}
SRHalo class >> initialHaloCenterFor: globalPoint in: aWorld [
	
	"Initial center position of a Halo for a given point in the world."
	^ SRWorld haloAnchor caseOf: {
		[SRHaloAnchor lineOfSight] -> [self lineOfSightFor: globalPoint in: aWorld].
		[SRHaloAnchor staticLineOfSight] -> [self lineOfSightFor: globalPoint in: aWorld].
	}
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:48'
}
SRHalo class >> lineOfSightFor: globalPoint in: aWorld [

	| camera toPoint |
	camera := aWorld camera.
	toPoint := (globalPoint - camera globalTranslation) normalized.
	^ SRWorld haloDistance * toPoint + camera globalTranslation
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 16:15'
}
SRHalo >> addHandles [
	
	"Called when this Halo has popped up and should add the necessary buttons now."
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:37'
}
SRHalo >> center [

	"Position to draw helpers from."
	^ self globalTranslation
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:57'
}
SRHalo >> center: aPoint [

	self globalTranslation: aPoint
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:51'
}
SRHalo >> close [

	self isOpen ifTrue: [
		self haloState activeHalo: nil.
		self parent removeChild: self.
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:13'
}
SRHalo >> frozen [
	^ frozen
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:14'
}
SRHalo >> frozen: aBool [

	"If True, this halo does not try to move with the target, regardless of the anchor."
	frozen := aBool
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:02'
}
SRHalo >> haloSpec [ 

	"Halos don't want a Halo themselves."
	^ nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:15'
}
SRHalo >> initialize [ 

	super initialize.
	self haloMode: SRHaloMode forbid.
	frozen := false.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/6/2026 10:51'
}
SRHalo >> isHalo [ 
	^true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:00'
}
SRHalo >> isOpen [

	^ self world isNil not
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:11'
}
SRHalo >> moveToLineOfSight: deltaTime [ 

	"Position myself in line-of-sight of the user, but smoothly interpolated across frames."		
	| los point |
	point := self target globalTransform localPointToGlobal: targetLocalPoint.
	los := self class lineOfSightFor: point in: self world.
	self center: (self center interpolateTo: los at: 3 * deltaTime).
	self lookAt: self world camera globalTranslation.

]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:01'
}
SRHalo >> popUpFor: anSRObject [ 
	
	| hand point |
	hand := anSRObject world avatar rightHand.
	point := anSRObject  globalTranslation.
	^ self popUpFor: anSRObject hand: hand point: point
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:54'
}
SRHalo >> popUpFor: anSRObject event: event [

	^ self
		popUpFor: anSRObject
		hand: event hand
		point: event point
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:05'
}
SRHalo >> popUpFor: anSRObject hand: aHand point: aPoint [
		
	"Pop up for an object triggered by a hand by clicking on the target at a point."
	| world |
	world := aHand world.
	targetLocalPoint := anSRObject globalTransform globalPointToLocal: aPoint.
	
	"Remove all other halos."
	world haloState
		closeHalo;
		activeHalo: self.
	
	self target: anSRObject.
	aHand halo: self.
	world addChild: self.
	
	"Position ourselves according to the user's preferences."
	self center: (self class initialHaloCenterFor: aPoint in: world).
	self lookAt: world camera globalTranslation.

	self addHandles.
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/15/2026 17:38'
}
SRHalo >> renderInSecondPass [ 

	^ true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:13'
}
SRHalo >> step: deltaTime [ 

	self frozen ifTrue: [^self].
	SRWorld haloAnchor caseOf: {
		[SRHaloAnchor staticLineOfSight] -> [].
		[SRHaloAnchor lineOfSight] -> [self moveToLineOfSight: deltaTime].
	}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:55'
}
SRHalo >> target [
	^target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/12/2026 15:59'
}
SRHalo >> target: anObject [

	target := anObject.
	Transcript showln: 'Target is ', target.
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/14/2026 15:55'
}
SRHalo >> wantsGrab [ 

	^ true
]
