"
Tools held per hand, and the preference that collapses the two into one.

Saves the class variable rather than the resolved value: nil is the documented ""use the code default"", and writing back a resolved Boolean would pin a literal.
"
Class {
	#name : #SRHandToolTest,
	#superclass : #TestCase,
	#instVars : [
		'savedSharedTool'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> setUp [
	super setUp.
	savedSharedTool := SRHand classPool at: #SharedTool.
	SRHand classPool at: #SharedTool put: nil.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> tearDown [
	SRHand classPool at: #SharedTool put: savedSharedTool.
	super tearDown.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:58'
}
SRHandToolTest >> testAHandOutsideAnAvatarCanStillBeArmed [
	"The shared case has no second hand to reach, and must not fail trying."

	| hand dig |
	hand := SRHand new.
	dig := SRTool new.
	SRHand sharedTool: true.
	hand tool: dig.
	self assert: dig == hand tool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 11:01'
}
SRHandToolTest >> testAToolDeclinesByDefault [
	"Declining is what leaves menus and panels working while a tool is held, so
	it is the default a subclass has to opt out of."

	self deny: (SRTool new handleRaycast: nil).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:57'
}
SRHandToolTest >> testArmingOneHandLeavesTheOtherEmpty [

	| avatar |
	avatar := SRAvatar new.
	avatar rightHand tool: SRTool new.
	self assert: avatar leftHand tool isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:58'
}
SRHandToolTest >> testArmingShowsTheToolOnTheHandAndDisarmingTakesItAway [

	| hand before |
	hand := SRHand new.
	before := hand children size.
	hand tool: SRTool new.
	self assert: before + 1 equals: hand children size.
	hand tool: nil.
	self assert: before equals: hand children size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:57'
}
SRHandToolTest >> testEachHandHoldsItsOwnTool [

	| avatar dig place |
	avatar := SRAvatar new.
	dig := SRTool new.
	place := SRTool new.
	avatar rightHand tool: dig.
	avatar leftHand tool: place.
	self assert: dig == avatar rightHand tool.
	self assert: place == avatar leftHand tool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:58'
}
SRHandToolTest >> testSwappingToolsDoesNotStackPreviews [
	"Six materials picked in a row would otherwise leave six cubes on the hand."

	| hand before |
	hand := SRHand new.
	before := hand children size.
	5 timesRepeat: [hand tool: SRTool new].
	self assert: before + 1 equals: hand children size.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:58'
}
SRHandToolTest >> testThePreviewIsNeitherPickableNorSolid [
	"It rides on the hand and crosses everything the player points at, so it must
	not answer a ray or hold the player up."

	| hand preview |
	hand := SRHand new.
	hand tool: SRTool new.
	preview := hand children last.
	self assert: preview safeCollisionGeometry isNil.
	self assert: (SRSceneSolids forObject: SRObject new) size isZero.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:58'
}
SRHandToolTest >> testTheSharedPreferenceArmsBothHands [

	| avatar laser |
	avatar := SRAvatar new.
	laser := SRTool new.
	SRHand sharedTool: true.
	avatar leftHand tool: laser.
	self assert: laser == avatar leftHand tool.
	self assert: laser == avatar rightHand tool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testTwoToolsIsTheCodeDefault [

	self deny: SRHand sharedTool.
]
