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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testAHandOutsideAnAvatarCanStillBeArmed [
	"The shared case has no second hand to reach, and must not fail trying."

	| hand |
	hand := SRHand new.
	SRHand sharedTool: true.
	hand tool: #dig.
	self assert: #dig equals: hand tool.
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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testArmingOneHandLeavesTheOtherEmpty [

	| avatar |
	avatar := SRAvatar new.
	avatar rightHand tool: #dig.
	self assert: avatar leftHand tool isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testEachHandHoldsItsOwnTool [

	| avatar |
	avatar := SRAvatar new.
	avatar rightHand tool: #dig.
	avatar leftHand tool: #place.
	self assert: #dig equals: avatar rightHand tool.
	self assert: #place equals: avatar leftHand tool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testTheSharedPreferenceArmsBothHands [

	| avatar |
	avatar := SRAvatar new.
	SRHand sharedTool: true.
	avatar leftHand tool: #laser.
	self assert: #laser equals: avatar leftHand tool.
	self assert: #laser equals: avatar rightHand tool.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 10:48'
}
SRHandToolTest >> testTwoToolsIsTheCodeDefault [

	self deny: SRHand sharedTool.
]
