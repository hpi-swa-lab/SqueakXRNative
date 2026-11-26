"
Tests that a head marker is hidden from its own avatar.
"
Class {
	#name : #SRHeadMarkerTest,
	#superclass : #TestCase,
	#instVars : [
		'avatar',
		'marker',
		'renderer'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:58'
}
SRHeadMarkerTest >> setUp [

	super setUp.
	avatar := SRAvatar new.
	marker := avatar headMarker.
	renderer := SRTestRenderer flat.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:31'
}
SRHeadMarkerTest >> testAnotherAvatarSeesIt [

	SRRenderingAvatarVariable value: SRAvatar new during: [marker renderOn: renderer].
	self assert: renderer events asArray = #(#cube).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:31'
}
SRHeadMarkerTest >> testTheMarkedAvatarDoesNotSeeIt [

	SRRenderingAvatarVariable value: avatar during: [marker renderOn: renderer].
	self assert: renderer events isEmpty.
]
