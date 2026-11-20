"
Elastic transition, as in Godot.
"
Class {
	#name : #SRElasticTransition,
	#superclass : #SRTransition,
	#category : #'SqueakXR-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRElasticTransition class >> period [

	^ 0.3
]

{
	#category : #easing,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:22'
}
SRElasticTransition >> in: aProgress [

	| shifted |
	(aProgress <= 0 or: [aProgress >= 1]) ifTrue: [^ aProgress].
	shifted := aProgress - 1.
	^ ((2 raisedTo: 10 * shifted) * ((shifted - (self class period / 4)) * 2 * Float pi / self class period) sin) negated
]
