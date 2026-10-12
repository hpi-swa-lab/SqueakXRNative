"
Covers the between-frame action queue, which used to be a class variable: the blocks capture the world and whatever they were about to add to it, so a stopped world that kept them kept all of it.
"
Class {
	#name : #SRWorldTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'previousWorld'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:16'
}
SRWorldTest >> setUp [
	"SRWorld>>isRunning: installs the receiver as SRWorld current, so it has to be put back."

	super setUp.
	previousWorld := SRWorld current.
	world := SRWorld new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 10/12/2026 17:45'
}
SRWorldTest >> tearDown [
	"isRunning: true has no process behind it here, and a world left running breaks
	SRWorld allInstances select: [:w | w isRunning]."

	world isRunning: false.
	SRWorld current: previousWorld.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testDeferredActionIsRefusedWhileNotRunning [
	world addDeferredFrameMessage: [self signalFailure: 'must not run'].
	self assert: world pendingFrameActions isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testDeferredActionRunsOnTheNextCycle [
	| ran |
	ran := false.
	world isRunning: true.
	world addDeferredFrameMessage: [ran := true].
	world runPendingBetweenFrameActions.
	self assert: ran.
	self assert: world pendingFrameActions isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/25/2026 13:17'
}
SRWorldTest >> testStopDropsDeferredActions [
	world isRunning: true.
	world addDeferredFrameMessage: [self signalFailure: 'must not run'].
	self deny: world pendingFrameActions isEmpty.
	world stop.
	self assert: world pendingFrameActions isEmpty.
]
