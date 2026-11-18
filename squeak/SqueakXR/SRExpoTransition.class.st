"
Expo transition, as in Godot.
"
Class {
	#name : #SRExpoTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRExpoTransition >> in: aProgress [

	aProgress <= 0 ifTrue: [^ 0].
	^ 2 raisedTo: 10 * (aProgress - 1)
]
