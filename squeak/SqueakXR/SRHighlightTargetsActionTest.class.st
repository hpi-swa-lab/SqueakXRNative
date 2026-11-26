Class {
	#name : #SRHighlightTargetsActionTest,
	#superclass : #TestCase,
	#instVars : [
		'isWorld',
		'highlighted'
	],
	#category : #'SqueakXR-Tests-Halo'
}

{
	#category : #'hand and target',
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> addHighlight: aColor [
	highlighted := aColor
]

{
	#category : #'hand and target',
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> color [
	^ Color green
]

{
	#category : #'hand and target',
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> cursorTarget [
	"I stand in for the hand and its target: a real target needs a world."
	^ self
]

{
	#category : #'hand and target',
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> isWorldObject [
	^ isWorld
]

{
	#category : #running,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> runAction [
	^ SRHighlightTargetsAction new hand: self; run: nil
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> testAnObjectUnderTheRayIsHighlighted [
	isWorld := false.
	self assert: self runAction.
	self assert: highlighted = Color green.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 17:04'
}
SRHighlightTargetsActionTest >> testTheWorldUnderTheRayIsNotHighlighted [
	isWorld := true.
	self assert: self runAction.
	self assert: highlighted isNil.
]
