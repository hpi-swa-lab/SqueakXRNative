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
		'target'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:38'
}

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
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:02'
}
SRHalo >> haloSpec [ 

	"Halos don't want a Halo themselves."
	^ nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/9/2026 14:33'
}
SRHalo >> initialize [ 

	super initialize.
	self haloMode: SRHaloMode forbid.
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
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:52'
}
SRHalo >> popUpFor: anSRObject [ 
		
	^ self 
		popUpFor: anSRObject
		hand: (anSRObject world avatar rightHand)
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:46'
}
SRHalo >> popUpFor: anSRObject at: aPoint hand: aHand [

	"Remove any other halos."
	aHand haloState 
		closeHalo;
		activeHalo: self.
	
	self target: anSRObject.
	aHand halo: self.
	aHand world addChild: self.
	
	self globalTranslation: aPoint.
	self lookAt: self world camera globalTranslation.
	self addHandles.
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/12/2026 12:24'
}
SRHalo >> popUpFor: anSRObject event: event [

	| point |
	point := event point interpolateTo: event hand globalTranslation at: 0.5.
	^ self
		popUpFor: anSRObject
		at: point
		hand: event hand
]

{
	#category : #'pop up',
	#'squeak_changestamp' : 'phkeese 10/9/2026 13:53'
}
SRHalo >> popUpFor: anSRObject hand: aHand [
		
	^ self 
		popUpFor: anSRObject
		at: (aHand globalTranslation)
		hand: (anSRObject world avatar rightHand)
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
