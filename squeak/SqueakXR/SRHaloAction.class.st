"
A SRHaloAction is an action to be performed using the Halo, e.g. resize, move, inspect, etc.

Instance Variables
active - Is this action currently active?
hand   - Hand that triggered this action
sticky - Is this action sticky (active over multiple frames)?
target - Object targeted by this action.

"
Class {
	#name : #SRHaloAction,
	#superclass : #Object,
	#instVars : [
		'target',
		'hand',
		'active',
		'sticky'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:16'
}

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:50'
}
SRHaloAction >> activate [
	"Start performing the action."
	^ self subclassResponsibility 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:05'
}
SRHaloAction >> active [
	^ active
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:05'
}
SRHaloAction >> active: anObject [
	active := anObject
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:50'
}
SRHaloAction >> deactivate [
	"Stop performing this action."
	^ self subclassResponsibility 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:06'
}
SRHaloAction >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:06'
}
SRHaloAction >> hand: anObject [
	hand := anObject
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:07'
}
SRHaloAction >> initialize [ 

	active = false
]

{
	#category : #events,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:11'
}
SRHaloAction >> step: deltaTime [
	"Update this action"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:14'
}
SRHaloAction >> sticky [
	^ sticky
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:14'
}
SRHaloAction >> sticky: anObject [
	sticky := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:05'
}
SRHaloAction >> target [
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 15:05'
}
SRHaloAction >> target: anObject [
	target := anObject
]
