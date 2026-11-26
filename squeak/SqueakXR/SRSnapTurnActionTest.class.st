"
Tests SRTurnAction.
"
Class {
	#name : #SRSnapTurnActionTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Halo',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:55'
}
SRSnapTurnActionTest >> aim: aHand at: anObject [
	aHand instVarNamed: #firstIntersection put: (SRIntersectionResult new object: anObject; yourself).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:55'
}
SRSnapTurnActionTest >> testAFocusedPanelUnderTheRayKeepsTheStickFromTurning [
	self withSnapTurnDo: [ | avatar action world panel before |
		avatar := SRAvatar new.
		action := SRSnapTurnAction new hand: avatar rightHand; yourself.
		world := SRWorld new.
		panel := SRMorphPanel new.
		world addChild: panel.
		world keyboardFocus: panel.
		self aim: avatar rightHand at: (panel children detect: [:each | each isKindOf: SRPlane]).
		avatar rightHand inputState joystick horizontal: 1.
		before := avatar rotation.
		action run: avatar rightHand inputState.
		self assert: before equals: avatar rotation].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 15:32'
}
SRSnapTurnActionTest >> testASnapTurnWaitsForTheStickToReturn [

	| avatar action turned |
	avatar := SRAvatar new.
	action := SRSnapTurnAction new.
	action snapTurn: avatar by: 1.
	turned := avatar rotation.
	action snapTurn: avatar by: 1.
	self assert: turned equals: avatar rotation.
	action snapTurn: avatar by: 0.
	action snapTurn: avatar by: 1.
	self deny: turned = avatar rotation.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:55'
}
SRSnapTurnActionTest >> testAnUnfocusedPanelUnderTheRayLeavesTheStickTurning [
	self withSnapTurnDo: [ | avatar action world panel before |
		avatar := SRAvatar new.
		action := SRSnapTurnAction new hand: avatar rightHand; yourself.
		world := SRWorld new.
		panel := SRMorphPanel new.
		world addChild: panel.
		self aim: avatar rightHand at: (panel children detect: [:each | each isKindOf: SRPlane]).
		avatar rightHand inputState joystick horizontal: 1.
		before := avatar rotation.
		action run: avatar rightHand inputState.
		self deny: before = avatar rotation].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:55'
}
SRSnapTurnActionTest >> testLeavingTheFocusedPanelTurnsOnlyAfterTheStickReturns [
	self withSnapTurnDo: [ | avatar action world panel before |
		avatar := SRAvatar new.
		action := SRSnapTurnAction new hand: avatar rightHand; yourself.
		world := SRWorld new.
		panel := SRMorphPanel new.
		world addChild: panel.
		world keyboardFocus: panel.
		self aim: avatar rightHand at: (panel children detect: [:each | each isKindOf: SRPlane]).
		avatar rightHand inputState joystick horizontal: 1.
		action run: avatar rightHand inputState.
		self aim: avatar rightHand at: SRObject new.
		before := avatar rotation.
		action run: avatar rightHand inputState.
		self assert: before equals: avatar rotation.
		avatar rightHand inputState joystick horizontal: 0.
		action run: avatar rightHand inputState.
		avatar rightHand inputState joystick horizontal: 1.
		action run: avatar rightHand inputState.
		self deny: before = avatar rotation].
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 16:55'
}
SRSnapTurnActionTest >> withSnapTurnDo: aBlock [
	| saved |
	saved := SRAvatar turnStyle.
	[SRAvatar turnStyle: #snap.
	aBlock value] ensure: [SRAvatar turnStyle: saved].
]
