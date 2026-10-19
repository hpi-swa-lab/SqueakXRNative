"
Scavenges at the start of a frame once eden is more than #frameStartEdenPercent full, so the scavenge does not fall in the middle of a frame.
"
Class {
	#name : #SRFrameScavenger,
	#superclass : #Object,
	#classVars : [
		'ForcedScavenges',
		'FrameStartEdenPercent',
		'ScavengeAtFrameStart'
	],
	#category : #'SqueakXR-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> forcedScavenges [
	"How many scavenges the frame-start check has caused, for telling an experiment
	that worked from one that simply did not fire."

	^ ForcedScavenges ifNil: [ForcedScavenges := 0].
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> frameStartEdenPercent [
	<preference: 'Scavenge at frame start: eden percent'
		category: 'SqueakXR'
		description: 'How full eden must be, in percent, before a frame start scavenges. Lower means more frequent, cheaper scavenges; 100 disables the early scavenge without disabling the check.'
		type: #Number>
	^ FrameStartEdenPercent ifNil: [FrameStartEdenPercent := 50].
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> frameStartEdenPercent: aNumber [
	FrameStartEdenPercent := (aNumber max: 1) min: 100.
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> resetForcedScavenges [
	ForcedScavenges := 0.
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> scavengeAtFrameStart [
	<preference: 'Scavenge at frame start'
		category: 'SqueakXR'
		description: 'Whether the render loop scavenges at the start of a frame once eden is more than #frameStartEdenPercent full, instead of letting the scavenge fall wherever eden happens to run out. A frame boundary is where the frame has no half-built objects live, so fewer of them survive.'
		type: #Boolean>
	^ ScavengeAtFrameStart ifNil: [ScavengeAtFrameStart := false].
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> scavengeAtFrameStart: aBoolean [
	ScavengeAtFrameStart := aBoolean.
]

{
	#category : #gc,
	#'squeak_changestamp' : 'MCPServer (leo) 10/19/2026 16:09'
}
SRFrameScavenger class >> scavengeIfEdenFull [
	"Objects half-built by a frame are live roots at the moment a scavenge looks at
	them, so one that falls wherever eden runs out mid-frame keeps more than one taken
	at a frame boundary. Called first in #doOneCycle for that reason.

	p2 is young space in use, p44 is the eden capacity."

	| eden |
	self scavengeAtFrameStart ifFalse: [^ self].
	eden := Smalltalk vmParameterAt: 44.
	eden ifNil: [^ self].
	(Smalltalk vmParameterAt: 2) * 100 < (eden * self frameStartEdenPercent)
		ifTrue: [^ self].
	Smalltalk garbageCollectMost.
	ForcedScavenges := self forcedScavenges + 1.
]
