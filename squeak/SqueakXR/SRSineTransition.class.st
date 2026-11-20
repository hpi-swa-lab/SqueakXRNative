"
Sine transition, as in Godot.
"
Class {
	#name : #SRSineTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRSineTransition >> in: aProgress [

	^ 1 - (aProgress * Float pi / 2) cos
]
