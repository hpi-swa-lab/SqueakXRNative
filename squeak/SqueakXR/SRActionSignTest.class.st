"
Guards the sign that SRBenchmarkStopSign and SRCubeField both hang their only
control off.
"
Class {
	#name : #SRActionSignTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRActionSignTest >> testCollisionBoxCoversTheSlab [
	| sign box |
	sign := SRActionSign new position: 0 @ 1m @ -2m; yourself.
	box := sign collisionGeometry.
	self assert: sign equals: box object.
	self assert: sign size / 2 equals: box halfExtents.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRActionSignTest >> testLabelRoundTrips [
	| sign |
	sign := SRActionSign new label: 'hello'; yourself.
	self assert: 'hello' equals: sign label.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRActionSignTest >> testRaycastWithoutActionIsHarmless [
	SRActionSign new onRaycast: nil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:12'
}
SRActionSignTest >> testStopSignStillLabelsItself [
	| sign |
	sign := SRBenchmarkStopSign new.
	self assert: 'STOP' equals: sign label.
	self assert: sign isRendering.
	self assert: sign collisionGeometry notNil.
]
