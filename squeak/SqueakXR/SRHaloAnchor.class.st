"
A SRHaloAnchor is intended to be placed as a child of an SRHalo to anchor that halo according to the current haloAnchorMode preference of the user, every frame.
Instance Variables

"
Class {
	#name : #SRHaloAnchor,
	#superclass : #SRObject,
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 11/4/2026 16:47'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:08'
}
SRHaloAnchor class >> all [
	^(self class methodDict keys 
		reject: [:name | name = 'all' or: name = 'default' ]) collect: [:each |
		self perform: each
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 15:08'
}
SRHaloAnchor class >> default [
	^ self lineOfSight 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/30/2026 16:44'
}
SRHaloAnchor class >> inactiveHand [
	"Place the halo on the inactive hand of the user and disable its cursor."
	^'inactiveHand'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:04'
}
SRHaloAnchor class >> lineOfSight [
	"Place Halo between the user's head and the center point and move with the user's head and the target."
	^'lineOfSight'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:04'
}
SRHaloAnchor class >> staticLineOfSight [
	"Place Halo between the user's head and the center point and stay there."
	^'staticLineOfSight'
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/4/2026 16:50'
}
SRHaloAnchor >> step: deltaTime [

	self parent frozen ifTrue: [^self].
	SRWorld haloAnchorMode caseOf: {
		[SRHaloAnchor staticLineOfSight] -> [].
		[SRHaloAnchor lineOfSight] -> [self parent moveToLineOfSight: deltaTime].
		[SRHaloAnchor inactiveHand] -> [self parent globalTransform: self parent hand opposite haloTransform].
	}


]
