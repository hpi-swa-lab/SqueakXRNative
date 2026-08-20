"
A SRHaloSpec is a specification for a Halo on a specific SRObject.
It details the location in the world, the collision to use for highlighting and selection.

Instance Variables

"
Class {
	#name : #SRHaloSpec,
	#superclass : #Object,
	#instVars : [
		'target',
		'collision'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:29'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:39'
}
SRHaloSpec >> collision [
	^ collision
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:39'
}
SRHaloSpec >> collision: anObject [
	collision := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:39'
}
SRHaloSpec >> target [
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:39'
}
SRHaloSpec >> target: anObject [
	target := anObject
]
