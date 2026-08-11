"
A SRGoGoExtender is a component which amplifies the user's motion to reach farther in the scene.
See 'The Go-Go Interaction Technique: Non-linear Mapping for Direct Manipulation in VR' for details.

Instance Variables

"
Class {
	#name : #SRGoGoExtender,
	#superclass : #SRObject,
	#instVars : [
		'k',
		'hand',
		'linearDistance',
		'shoulderCube'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 8/10/2026 14:19'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 14:40'
}
SRGoGoExtender >> color: aColor [
	self childrenDo: [:c | c color: aColor]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 15:26'
}
SRGoGoExtender >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 15:26'
}
SRGoGoExtender >> hand: anObject [
	hand := anObject
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:36'
}
SRGoGoExtender >> initialize [ 
	super initialize.
	
	k := 10.
	linearDistance := 0.3.
	shoulderCube := SRCube new scale: 5cm asVector3.
	self addChild: shoulderCube.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:11'
}
SRGoGoExtender >> k [
	^ k
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:11'
}
SRGoGoExtender >> k: anObject [
	k := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:17'
}
SRGoGoExtender >> linearDistance [
	^ linearDistance
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:17'
}
SRGoGoExtender >> linearDistance: anObject [
	linearDistance := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 15:26'
}
SRGoGoExtender >> origin [
	^ self hand shoulderPosition
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 16:16'
}
SRGoGoExtender >> scaleFactor [
	"Scale factor to multiply with self vector."
	| r |
	r := (self globalTranslation - self origin) length.
	^ (r < self linearDistance)
		ifTrue: [ 1.0 ]
		ifFalse: [
			| tmp |
			tmp := r - self linearDistance.
			(self k * tmp * tmp + r) / r
		]
]

{
	#category : #stepping,
	#'squeak_changestamp' : 'phkeese 8/11/2026 11:37'
}
SRGoGoExtender >> step: deltaTime [ 
	| p |
	p := self origin + (self vector * self scaleFactor).
	self childrenDo: [:child |
		child globalTranslation: p
	].
	shoulderCube globalTranslation: self origin.
	
	
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 8/10/2026 14:41'
}
SRGoGoExtender >> vector [
	^ self globalTranslation - self origin
]
