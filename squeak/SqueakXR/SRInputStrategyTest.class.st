"
Tests that an avatar's input strategy follows the avatar's world.
"
Class {
	#name : #SRInputStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'world'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:38'
}
SRInputStrategyTest >> setUp [

	super setUp.
	world := SRWorld new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRInputStrategyTest >> testAStrategyListensToTheWorldOfItsAvatar [

	| strategy avatar |
	strategy := SRXRControllerInputStrategy new.
	avatar := SRAvatar inputStrategy: strategy.
	self deny: (world dependents includes: strategy).
	world addChild: avatar.
	self assert: (world dependents includes: strategy).
	avatar remove.
	self deny: (world dependents includes: strategy).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 18:19'
}
SRInputStrategyTest >> testDetachingControllerInputBringsBackTheControllerHands [

	| avatar |
	avatar := SRAvatar inputStrategy: SRXRControllerInputStrategy new.
	avatar enableHandTracking.
	avatar useTrackedHands.
	avatar inputStrategy: nil.
	self assert: (avatar hands allSatisfy: [:each | avatar isUsing: each]).
	self assert: (avatar trackedHands noneSatisfy: [:each | avatar isUsing: each]).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/23/2026 18:19'
}
SRInputStrategyTest >> testEitherActiveHandSwitchesBothHandsToTracking [

	| strategy avatar joints |
	strategy := SRXRControllerInputStrategy new.
	avatar := SRAvatar inputStrategy: strategy.
	avatar enableHandTracking.
	joints := SRXrHandJoints new.
	joints leftIsActive: (XrBool32 on: 1).
	strategy handJointsUpdated: joints.
	self assert: avatar activeHands isEmpty.
	self assert: (avatar trackedHands allSatisfy: [:each | avatar isUsing: each]).
	joints leftIsActive: (XrBool32 on: 0).
	strategy handJointsUpdated: joints.
	self assert: avatar activeHands asArray equals: avatar hands.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRInputStrategyTest >> testOnlyControllerInputDrivesFromControllers [

	self assert: (SRAvatar inputStrategy: SRXRControllerInputStrategy new) isControllerDriven.
	self deny: (SRAvatar inputStrategy: SRDesktopInputStrategy new) isControllerDriven.
	self deny: SRAvatar new isControllerDriven.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRInputStrategyTest >> testReplacingTheStrategyReleasesTheOldOne [

	| old new avatar |
	old := SRXRControllerInputStrategy new.
	new := SRXRControllerInputStrategy new.
	avatar := SRAvatar inputStrategy: old.
	world addChild: avatar.
	avatar inputStrategy: new.
	self deny: (world dependents includes: old).
	self assert: (world dependents includes: new).
	self assert: old avatar isNil.
	self assert: new avatar == avatar.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:57'
}
SRInputStrategyTest >> testTheDebugHUDBelongsToItsAvatar [

	| strategy avatar |
	strategy := SRDesktopInputStrategy new.
	avatar := SRAvatar inputStrategy: strategy.
	self assert: strategy debugHUD parent == avatar.
	avatar inputStrategy: nil.
	self assert: strategy debugHUD parent isNil.
]
