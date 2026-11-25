"
Tests how a world gets its avatar before starting.
"
Class {
	#name : #SRWorldSetUpTest,
	#superclass : #TestCase,
	#instVars : [
		'world'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> setUp [

	super setUp.
	world := SRWorld new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:16'
}
SRWorldSetUpTest >> testAnAvatarRendersNothingByDefault [

	self deny: SRAvatar new renderer rendersViews.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRWorldSetUpTest >> testAnEmptyWorldGetsTheAvatar [

	| avatar |
	avatar := SRAvatar new.
	self assert: (world ensureAvatar: avatar).
	self assert: world avatars asArray = {avatar}.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRWorldSetUpTest >> testAnExistingAvatarIsKeptWhenProceeding [

	| proceeds |
	world addChild: SRAvatar new.
	proceeds := [world ensureAvatar: SRAvatar new]
		valueSupplyingAnswers: #(#('*already set up*' true)).
	self assert: proceeds.
	self assert: world avatars size = 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRWorldSetUpTest >> testDecliningStopsTheStart [

	| proceeds |
	world addChild: SRAvatar new.
	proceeds := [world ensureAvatar: SRAvatar new]
		valueSupplyingAnswers: #(#('*already set up*' false)).
	self deny: proceeds.
	self assert: world avatars size = 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRWorldSetUpTest >> testOnlyAnAvatarThatCanRejoinMayLeave [

	self assert: (SRWorld canLeaveWhileRunning: (SRAvatar inputStrategy: SRDesktopInputStrategy new renderer: SRTestRenderer flat)).
	self deny: (SRWorld canLeaveWhileRunning: (SRAvatar inputStrategy: SRXRControllerInputStrategy new renderer: SRTestRenderer xr)).
	self deny: (SRWorld canLeaveWhileRunning: SRAvatar new).
	self deny: (SRWorld canLeaveWhileRunning: nil).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRWorldSetUpTest >> testTheWorldIsXRWhenAHeadsetRendererIsSetUp [

	world addChild: (SRAvatar inputStrategy: SRXRControllerInputStrategy new renderer: SRTestRenderer xr).
	self deny: world isXR.
	world rendererOrchestrator setUp.
	self assert: world isXR.
]
