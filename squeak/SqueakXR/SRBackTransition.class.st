"
Back transition, as in Godot.
"
Class {
	#name : #SRBackTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRBackTransition class >> overshoot [

	^ 1.70158
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRBackTransition >> in: aProgress [

	| overshoot |
	overshoot := self class overshoot.
	^ aProgress * aProgress * ((overshoot + 1) * aProgress - overshoot)
]
