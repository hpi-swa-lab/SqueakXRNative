"
Frame cost of N open Workspaces, each holding the same 300 words, rendered as
Morphic panels in the world.

The changing phase appends a single character to each, which is the cheapest edit
a Workspace can take and therefore isolates the cost of the damage and the panel
texture re-upload from the cost of the text itself.
"
Class {
	#name : #SRWorkspaceRenderBenchmark,
	#superclass : #SRFrameSamplingBenchmark,
	#instVars : [
		'workspaces'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark class >> sampleText [
	"300 words of 'the quick brown fox', wrapped every nine so the panel gets a
	realistic number of lines rather than one very long one."
	| words |
	words := 'the quick brown fox jumps over the lazy dog' substrings.
	^ String streamContents: [:s |
		1 to: 300 do: [:i |
			s nextPutAll: (words at: i - 1 \\ words size + 1).
			i \\ words size = 0 ifTrue: [s cr] ifFalse: [s nextPut: $ ]]]
]

{
	#category : #menu,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark class >> xrMenuRun: aMenu [
	<xrMenu: #(world profile benchmarks) label: 'Workspace rendering' priority: 224>
	^ self runFromMenu
]

{
	#category : #reporting,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:47'
}
SRWorkspaceRenderBenchmark >> description [
	^ 'Frame cost of N open Workspaces rendered as Morphic panels, swept 0 to 100.
Every Workspace holds the same 300 words of ''the quick brown fox jumps over the
lazy dog''; the rows differ only in how many windows there are. They are laid out
in rings of ', self panelsPerRing printString, ' at ', self ringRadius printString, ' m around the origin and stacked upwards, so
what is measured is many panels being drawn rather than many panels hiding
behind one another.
Three phases per row: the windows are opened (create ms), then the world is
watched for ', (self framesFor: nil) printString, ' frames with nothing touching them (still), then for as many
again while one character is appended to each every ', self mutationInterval printString, ' ms (chg).
The windows are closed again afterwards. still fps is what open windows cost to
draw; the gap to chg fps is what editing them costs.'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> framesFor: aParameter [
	^ 10
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> installFixture: aParameter [
	| text |
	text := self class sampleText.
	workspaces := (1 to: aParameter) collect: [:i | | window panel position |
		window := (Workspace new contents: text) openLabel: 'Bench ', i printString.
		panel := self panelFor: window.
		panel ifNotNil: [
			position := self positionForIndex: i.
			panel globalTransform: (Matrix4x4
				objectLookAt: 0 @ position y @ 0
				from: position
				up: Vector3 up)].
		window].
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/21/2026 17:06'
}
SRWorkspaceRenderBenchmark >> mutateFixture: aParameter [
	"One character each: the cheapest edit a Workspace can take, so what this costs
	is the damage and the panel texture re-upload, not the text."
	workspaces do: [:window |
		window allMorphs
			detect: [:each | each isTextMorph]
			ifFound: [:text | text contents: text text asString , 'x']
			ifNone: []].
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark >> mutatesFixture [
	^ true
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> panelFor: aWindow [
	"SRPasteUpMorph>>addedMorph: wraps a newly opened window in a panel and parks it
	1.25 m in front of the camera, so every one of them lands in the same place."
	^ self world children
		detect: [:each | each isMorphPanel and: [each morph == aWindow]]
		ifNone: [nil]
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> panelsPerRing [
	^ 12
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark >> parameterName [
	^ 'workspaces'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark >> parameterNote [
	^ 'Workspaces opened for this row, each with the same 300 words, closed afterwards'
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> parameters [
	^ (0 to: 100 by: 10) asArray
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> positionForIndex: i [
	"Rings of #panelsPerRing around the origin, stacked upwards. Spread out so the
	measurement is of many panels being drawn rather than of many panels occluding
	each other."
	| angle ring |
	angle := (i - 1 \\ self panelsPerRing) * 2 * Float pi / self panelsPerRing.
	ring := i - 1 // self panelsPerRing.
	^ (self ringRadius * angle sin)
		@ (1.2m + (ring * 1.3m))
		@ (self ringRadius * angle cos) negated
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:06'
}
SRWorkspaceRenderBenchmark >> removeFixture: aParameter [
	workspaces ifNil: [^ self].
	workspaces do: [:each | each delete].
	workspaces := nil.
]

{
	#category : #configuring,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 18:46'
}
SRWorkspaceRenderBenchmark >> ringRadius [
	^ 3m
]
