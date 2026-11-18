"
Quart transition, as in Godot.
"
Class {
	#name : #SRQuartTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRQuartTransition >> in: aProgress [

	^ aProgress raisedTo: 4
]
