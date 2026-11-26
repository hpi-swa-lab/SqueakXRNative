"
Tests dragging held objects with the desktop input strategy.
"
Class {
	#name : #SRDesktopInputStrategyTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRDesktopInputStrategyTest >> testAHeldObjectComesAlongWhenWalking [

	| strategy moved |
	strategy := SRDesktopInputStrategy new.
	strategy beginDrag: (Matrix4x4 withOffset: 0 @ 1 @ -2) holding: 0 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	moved := strategy dragTransformTo: 0 @ 1 @ -3 from: 0 @ 1.8 @ -1.
	self assert: (moved translation - (0 @ 1 @ -3)) length < 1e-5.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRDesktopInputStrategyTest >> testAHeldObjectStaysPutWhileStandingStill [

	| strategy held |
	strategy := SRDesktopInputStrategy new.
	strategy beginDrag: (Matrix4x4 withOffset: 0.5 @ 1 @ -2) holding: 0.5 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	held := strategy dragTransformTo: 0.5 @ 1 @ -2 from: 0 @ 1.8 @ 0.
	self assert: (held translation - (0.5 @ 1 @ -2)) length < 1e-5.
]
