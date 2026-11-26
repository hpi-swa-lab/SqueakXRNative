"
Tests which avatars a world lists.
"
Class {
	#name : #SRWorldAvatarsTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'avatar'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> setUp [

	super setUp.
	world := SRWorld new.
	avatar := SRAvatar new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> testAnAvatarComesAndGoesWithItsSubtree [

	| holder |
	holder := SRObject new.
	holder addChild: avatar.
	world addChild: holder.
	self assert: world avatars asArray = {avatar}.
	holder remove.
	self assert: world avatars isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> testAnAvatarEnteringAndLeavingTheWorld [

	world addChild: avatar.
	self assert: world avatars asArray = {avatar}.
	avatar remove.
	self assert: world avatars isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> testAnAvatarMovingToAnotherWorldLeavesTheFirst [

	| other |
	other := SRWorld new.
	world addChild: avatar.
	other addChild: avatar.
	self assert: world avatars isEmpty.
	self assert: other avatars asArray = {avatar}.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> testAvatarsAreListedInTheOrderTheyJoined [

	| second |
	second := SRAvatar new.
	world addChild: second; addChild: avatar.
	self assert: world avatars asArray = {second. avatar}.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:53'
}
SRWorldAvatarsTest >> testMovingAnAvatarWithinTheWorldListsItOnce [

	| holder |
	holder := SRObject new.
	world addChild: holder; addChild: avatar.
	holder addChild: avatar.
	self assert: world avatars asArray = {avatar}.
]
