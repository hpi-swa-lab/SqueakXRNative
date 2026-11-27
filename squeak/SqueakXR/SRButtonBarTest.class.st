Class {
	#name : #SRButtonBarTest,
	#superclass : #TestCase,
	#instVars : [
		'bar',
		'picked'
	],
	#category : #'SqueakXR-Tests-Objects'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> press: aButton [
	aButton handleInput: (SRInputEventButton new
		button: #trigger;
		pressed: true;
		yourself).
]

{
	#category : #running,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> setUp [
	super setUp.
	picked := OrderedCollection new.
	bar := SRButtonBar new.
	bar addButton: 'One' action: [picked add: #one].
	bar addButton: 'A longer label' action: [picked add: #two].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testALongerLabelGetsAWiderButton [
	self assert: bar buttons second width > bar buttons first width.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testAnEmptyBarCannotBeHit [
	self assert: SRButtonBar new collisionGeometry isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testButtonsGrabWhatTheBarGrabs [
	| owner |
	owner := SRObject new.
	bar grabTarget: owner.
	bar buttons do: [:each | self assert: each grabTarget identical: owner].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testButtonsSitLeftToRightInsideTheSlab [
	| first second |
	first := bar buttons first.
	second := bar buttons second.
	self assert: first position x + (first width / 2) < (second position x - (second width / 2)).
	self assert: first position x - (first width / 2) > (bar slabWidth / -2).
	self assert: second position x + (second width / 2) < (bar slabWidth / 2).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testPickingKeepsTheBarAndItsButtons [
	| container |
	container := SRObject new.
	container addChild: bar.
	self press: bar buttons first.
	self assert: bar parent identical: container.
	self assert: bar buttons size equals: 2.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/27/2026 15:26'
}
SRButtonBarTest >> testPressingAButtonRunsOnlyItsAction [
	self press: bar buttons second.
	self assert: picked asArray equals: #(#two).
]
