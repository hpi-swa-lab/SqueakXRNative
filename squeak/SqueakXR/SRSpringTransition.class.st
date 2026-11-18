"
Spring transition, as in Godot.
"
Class {
	#name : #SRSpringTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRSpringTransition >> in: aProgress [

	^ 1 - (self out: 1 - aProgress)
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRSpringTransition >> out: aProgress [

	| remaining |
	remaining := (1 - aProgress) asFloat.
	^ ((aProgress * Float pi * (0.2 + (2.5 * aProgress * aProgress * aProgress))) sin * (remaining raisedTo: 2.2) + aProgress)
		* (1 + (1.2 * remaining))
]
