"
Quad transition, as in Godot.
"
Class {
	#name : #SRQuadTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRQuadTransition >> in: aProgress [

	^ aProgress * aProgress
]
