"
A SRHalo is a Halo-like object in the world providing quick authoring tools and a way to inspect a target object.

Instance Variables

"
Class {
	#name : #SRHalo,
	#superclass : #SRObject,
	#instVars : [
		'target'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 8/18/2026 14:42'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:48'
}
SRHalo class >> specsIn: aSRWorld [
	"Collect Halo specs in the world."
	| targets |
	targets := OrderedCollection new.
	aSRWorld allDescendants do: [:object |
		object haloSpec ifNotNil: [ targets add: object haloSpec ]
	].
	^ targets
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 14:54'
}
SRHalo >> target [
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/18/2026 14:54'
}
SRHalo >> target: anObject [
	target := anObject
]
