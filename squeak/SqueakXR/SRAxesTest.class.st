"
Tests SRAxes and the SRObject/SRWorld protocol that installs it.

ShowAxes is saved and restored: it is a preference on the live world, and a test
that left it set would turn axes on in Jens's scene.
"
Class {
	#name : #SRAxesTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'previousWorld',
		'savedShowAxes'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:05'
}
SRAxesTest >> setUp [
	"SRWorld new installs nothing by itself, but SRAxes class>>showAxes: reaches for
	SRWorld current, so the live world has to be out of the way."

	super setUp.
	savedShowAxes := SRAxes classPool at: #ShowAxes ifAbsent: [nil].
	SRAxes classPool at: #ShowAxes put: nil.
	previousWorld := SRWorld current.
	world := SRWorld new.
	SRWorld current: world.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:05'
}
SRAxesTest >> tearDown [
	"Restored even when a test fails, so running the tests can never switch the live
	world's axes on."

	SRAxes classPool at: #ShowAxes put: savedShowAxes.
	world isRunning: false.
	SRWorld current: previousWorld.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testBarsAreNotObstacles [
	"Axes ride on tracked objects, so a bar with collision geometry would sit
	permanently between a ray and the world."

	| axes |
	axes := SRAxes length: 1m.
	self deny: axes isSolid.
	axes children do: [:each |
		self assert: each safeCollisionGeometry isNil
			description: each name, ' has collision geometry'].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testEachBarSpansItsOwnHalfAxis [
	"A bar of extent l centred at l/2 reaches the origin at one end and l at the other,
	which is what makes the dim half readable as the negative direction."

	| axes |
	axes := SRAxes length: 1m.
	{'+X' -> (0.5 @ 0 @ 0). '-X' -> (-0.5 @ 0 @ 0).
	 '+Y' -> (0 @ 0.5 @ 0). '-Y' -> (0 @ -0.5 @ 0).
	 '+Z' -> (0 @ 0 @ 0.5). '-Z' -> (0 @ 0 @ -0.5)} do: [:each |
		| bar |
		bar := axes children detect: [:candidate | candidate name = each key].
		self assert: 0.001 > (bar translation - each value) length
			description: each key, ' sits at ', bar translation printString].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testEachFrameGetsItsOwnSize [
	"Equal lengths would draw the world's axes and an avatar at the origin on top of
	each other."

	| avatar |
	avatar := SRAvatar new.
	world avatar: avatar.
	world addChild: avatar.
	SRAxes showAxes: true.
	self assert: world debugAxesLength equals: world axes length.
	self assert: avatar debugAxesLength equals: avatar axes length.
	self assert: avatar camera debugAxesLength equals: avatar camera axes length.
	self deny: world debugAxesLength = avatar debugAxesLength.
	self deny: avatar debugAxesLength = avatar camera debugAxesLength.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testGhostAnchorsGetAxesOnEnteringOutOfBody [
	"The ghost's head anchor is the only visible copy of the camera frame, so it is the
	one that has to carry axes while out of body."

	| avatar |
	avatar := SRAvatar new.
	world avatar: avatar.
	world addChild: avatar.
	SRAxes showAxes: true.
	self assert: (world debugAxesTargets noneSatisfy: [:each | each name = 'GhostHeadAnchor']).
	avatar enterOutOfBody.
	avatar ghostAvatar anchors do: [:each |
		self assert: each axes notNil description: each name, ' has no axes'].
	avatar exitOutOfBody.
	self assert: 3 equals: world debugAxesTargets size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:44'
}
SRAxesTest >> testLettersAndMetreTicks [

	| axes labelled |
	axes := SRAxes length: 4m.
	labelled := [:name | axes children detect: [:each | each name = name]].
	#(#('LetterX' 'x') #('LetterY' 'y') #('LetterZ' 'z')) do: [:pair |
		self assert: pair second equals: (labelled value: pair first) text].
	#('X' 'Y' 'Z') do: [:axis |
		1 to: 4 do: [:metre |
			self assert: metre printString equals: (labelled value: axis , metre printString) text]].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testNegativeHalfIsDimmerThanPositive [

	| axes |
	axes := SRAxes length: 1m.
	#(#('+X' '-X') #('+Y' '-Y') #('+Z' '-Z')) do: [:pair |
		| bright dim |
		bright := axes children detect: [:each | each name = pair first].
		dim := axes children detect: [:each | each name = pair second].
		self assert: dim color luminance < bright color luminance
			description: pair second, ' is not dimmer than ', pair first].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testShowAxesIsIdempotent [

	| object |
	object := SRObject new.
	self assert: object axes isNil.
	object showAxes: true.
	object showAxes: true.
	self assert: 1 equals: (object children count: [:each | each isAxes]).
	object showAxes: false.
	object showAxes: false.
	self assert: object axes isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:44'
}
SRAxesTest >> testSixBarsAndAnOrigin [

	| axes |
	axes := SRAxes length: 1m.
	self assert: 7 equals: (axes children count: [:each | each isCube]).
	#('Origin' '+X' '-X' '+Y' '-Y' '+Z' '-Z') do: [:each |
		self assert: (axes children anySatisfy: [:bar | bar name = each])
			description: 'missing bar ', each].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 10/20/2026 18:44'
}
SRAxesTest >> testTicksSitOnTheirOwnAxis [
	"The tick is offset sideways so the bar does not cover it, but its distance along
	its own axis has to be exactly the metre it names."

	| axes labelled |
	axes := SRAxes length: 4m.
	labelled := [:name | axes children detect: [:each | each name = name]].
	1 to: 4 do: [:metre |
		self assert: metre equals: (labelled value: 'X' , metre printString) translation x.
		self assert: metre equals: (labelled value: 'Y' , metre printString) translation y.
		self assert: metre equals: (labelled value: 'Z' , metre printString) translation z].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testTurningThePreferenceOffRemovesEveryAxes [

	| avatar |
	avatar := SRAvatar new.
	world avatar: avatar.
	world addChild: avatar.
	SRAxes showAxes: true.
	avatar enterOutOfBody.
	SRAxes showAxes: false.
	self assert: (world allDescendantsDetect: [:each | each isAxes] ifNone: [nil]) isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:06'
}
SRAxesTest >> testWorldWithoutAvatarHasOnlyItsOwnAxes [

	self assert: (Array with: world) equals: world debugAxesTargets asArray.
	SRAxes showAxes: true.
	self assert: world axes notNil.
]
