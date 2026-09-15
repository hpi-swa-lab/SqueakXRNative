"
A SRCursor is an abstract input handler for an SRHand. It receives trigger, grip & face button inputs and selects objects in the world.

Instance Variables
hand - SRHand this cursor belongs to
"
Class {
	#name : #SRCursor,
	#superclass : #SRObject,
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 9/14/2026 14:55'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:29'
}
SRCursor >> hand [

	"Hand object I belong to."
	^ self parent
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:26'
}
SRCursor >> onActionsUpdated [

	"Called when my hand's actions have been updated but before it emits input events"
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:36'
}
SRCursor >> onAnalogInput: anAnalogEvent [
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:36'
}
SRCursor >> onButtonInput: aButtonEvent [
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:12'
}
SRCursor >> parent: anSRObject [

	self parent ifNotNil: [ :parent | parent removeDependent: self ].
	super parent: anSRObject.
	self parent ifNotNil: [ :parent | parent addDependent: self ].
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
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:35'
}
SRCursor >> update: anAspect [

	anAspect = #actionsUpdated ifTrue: [ self onActionsUpdated ].
]

{
	#category : #updating,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:36'
}
SRCursor >> update: anAspect with: anObject [

	anAspect = #buttonInput ifTrue: [ self onButtonInput: anObject ].
	anAspect = #analogInput ifTrue: [ self onAnalogInput: anObject ].
]
