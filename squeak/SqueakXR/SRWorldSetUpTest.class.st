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
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> testAnAvatarWithoutInputIsNotConfigured [

	world addChild: SRAvatar new.
	self should: [world configuredAvatar] raise: AssertionFailure.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> testAnEmptyWorldGetsAnAvatarDrivenByTheStrategy [

	self assert: (world ensureAvatarWith: SRDesktopInputStrategy).
	self assert: world avatars size = 1.
	self assert: (world avatars first inputStrategy isKindOf: SRDesktopInputStrategy).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> testAnExistingAvatarIsKeptWhenProceeding [

	| proceeds |
	world addChild: SRAvatar new.
	proceeds := [world ensureAvatarWith: SRDesktopInputStrategy]
		valueSupplyingAnswers: #(#('*already set up*' true)).
	self assert: proceeds.
	self assert: world avatars size = 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> testDecliningStopsTheStart [

	| proceeds |
	world addChild: SRAvatar new.
	proceeds := [world ensureAvatarWith: SRDesktopInputStrategy]
		valueSupplyingAnswers: #(#('*already set up*' false)).
	self deny: proceeds.
	self assert: world avatars size = 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 14:15'
}
SRWorldSetUpTest >> testTheConfiguredAvatarMatchesTheMode [

	| headset desktop |
	headset := SRAvatar inputStrategy: SRXRControllerInputStrategy new.
	desktop := SRAvatar inputStrategy: SRDesktopInputStrategy new.
	world addChild: headset; addChild: desktop.
	world isXR: true.
	self assert: world configuredAvatar == headset.
	world isXR: false.
	self assert: world configuredAvatar == desktop.
]
