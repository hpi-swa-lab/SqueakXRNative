"
Quint transition, as in Godot.
"
Class {
	#name : #SRQuintTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRQuintTransition >> in: aProgress [

	^ aProgress raisedTo: 5
]
