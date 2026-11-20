"
Bounce transition, as in Godot.
"
Class {
	#name : #SRBounceTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRBounceTransition >> in: aProgress [

	^ 1 - (self out: 1 - aProgress)
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRBounceTransition >> out: aProgress [

	aProgress < (1 / 2.75) ifTrue: [^ self parabolaAt: aProgress offset: 0].
	aProgress < (2 / 2.75) ifTrue: [^ self parabolaAt: aProgress - (1.5 / 2.75) offset: 0.75].
	aProgress < (2.5 / 2.75) ifTrue: [^ self parabolaAt: aProgress - (2.25 / 2.75) offset: 0.9375].
	^ self parabolaAt: aProgress - (2.625 / 2.75) offset: 0.984375
]

{
	#category : #private,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRBounceTransition >> parabolaAt: aNumber offset: anOffset [

	^ 7.5625 * aNumber * aNumber + anOffset
]
