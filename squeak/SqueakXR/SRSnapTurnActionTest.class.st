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
