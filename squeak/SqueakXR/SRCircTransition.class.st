"
Circ transition, as in Godot.
"
Class {
	#name : #SRCircTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRCircTransition >> in: aProgress [

	^ 1 - (1 - (aProgress * aProgress)) sqrt
]
