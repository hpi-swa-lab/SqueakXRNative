Class {
	#name : #SRMorphPanelTest,
	#superclass : #TestCase,
	#instVars : [
		'xrWorld',
		'previousXRWorld',
		'morphicWorld'
	],
	#category : #'SqueakXR-Tests-Morphic'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> openWindowInMorphic [
	"A SystemWindow is one of the Morphs that answer #shouldBeInMorphPanel."

	| window |
	window := SystemWindow new.
	morphicWorld addMorph: window.
	^ window
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> panels [

	^ xrWorld children select: [:each | each isMorphPanel]
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:32'
}
SRMorphPanelTest >> setUp [

	super setUp.
	previousXRWorld := SRWorld current.
	xrWorld := SRWorld new.
	xrWorld avatar: SRAvatar new.
	xrWorld addChild: xrWorld avatar.
	"Never started, so nothing can load a shader: seed the one SRMorphTexture asks for."
	xrWorld renderer cacheAt: #morphTextureShader ifAbsentPut: [nil].
	xrWorld project: SRDummyMorphicProject new.
	SRWorld current: xrWorld.
	morphicWorld := xrWorld morphicWorld
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:16'
}
SRMorphPanelTest >> tearDown [

	"Delete before restoring: SRPasteUpMorph>>removedMorph: needs the XR world."
	morphicWorld ifNotNil: [morphicWorld submorphs do: [:each | each delete]].
	SRWorld current: previousXRWorld.
	super tearDown
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/17/2026 18:45'
}
SRMorphPanelTest >> testMorphInPanel [

	| morph panel |
	morph := Morph new.
	panel := SRDummyMorphPanel new.
	
	self deny: morph isInMorphPanel.
	panel morph: morph.
	self assert: morph isInMorphPanel.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testOpeningMorphInMorphicCreatesPanelInXR [

	| window |
	self assert: self panels isEmpty.
	window := self openWindowInMorphic.

	self assert: self panels size = 1.
	self assert: self panels first morph == window.
	self assert: window isInMorphPanel
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testRemountingPanelInXRReaddsMorphToMorphic [

	| window panel |
	window := self openWindowInMorphic.
	panel := self panels first.
	panel remove.

	xrWorld addChild: panel.

	self assert: panel morph == window.
	self assert: panel detachedMorph isNil.
	self assert: (morphicWorld submorphs includes: window).
	self assert: window owner == morphicWorld.
	self assert: window isInMorphPanel.
	"The remounted Morph must not make SRPasteUpMorph>>addedMorph: build a second panel."
	self assert: self panels size = 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testRemountingPanelWithoutMorphIsHarmless [

	| panel |
	panel := SRDummyMorphPanel new.
	xrWorld addChild: panel.
	panel remove.

	xrWorld addChild: panel.

	self assert: panel morph isNil.
	self assert: panel detachedMorph isNil
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/10/2026 15:15'
}
SRMorphPanelTest >> testRemovingPanelInXRRemovesMorphFromMorphic [

	| window panel |
	window := self openWindowInMorphic.
	panel := self panels first.

	panel remove.

	self assert: self panels isEmpty.
	self assert: panel morph isNil.
	self deny: (morphicWorld submorphs includes: window).
	self assert: window owner isNil.
	self deny: window isInMorphPanel.
	self assert: panel detachedMorph == window
]
