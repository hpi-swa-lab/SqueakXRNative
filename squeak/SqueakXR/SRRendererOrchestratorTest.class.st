"
Tests in which order and with which checks a world's renderers are processed.
"
Class {
	#name : #SRRendererOrchestratorTest,
	#superclass : #TestCase,
	#instVars : [
		'world',
		'orchestrator'
	],
	#category : #'SqueakXR-Tests-Graphics',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRRendererOrchestratorTest >> addAvatarRenderedBy: aRenderer [

	^ world addChild: (SRAvatar inputStrategy: SRDesktopInputStrategy new renderer: aRenderer)
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRRendererOrchestratorTest >> setUp [

	super setUp.
	world := SRWorld new.
	orchestrator := world rendererOrchestrator.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testADesktopUserJoiningIsSetUp [

	| renderer |
	self addAvatarRenderedBy: SRTestRenderer xr.
	orchestrator setUp.
	renderer := SRTestRenderer flat.
	self addAvatarRenderedBy: renderer.
	orchestrator processPendingChanges; processPendingChanges.
	self assert: renderer events asArray = #(#setup).
	self assert: (orchestrator isActive: renderer).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testADesktopUserLeavingIsShutDown [

	| renderer desktop |
	self addAvatarRenderedBy: SRTestRenderer xr.
	renderer := SRTestRenderer flat.
	desktop := self addAvatarRenderedBy: renderer.
	orchestrator setUp.
	desktop remove.
	orchestrator processPendingChanges.
	self assert: renderer events asArray = #(#setup #shutdown).
	self deny: (orchestrator isActive: renderer).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRRendererOrchestratorTest >> testAHeadsetAndADesktopUserCanStartTogether [

	world
		addChild: (SRAvatar xr);
		addChild: (SRAvatar desktop).
	self shouldnt: [orchestrator assertRenderable] raise: AssertionFailure.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testAHeadsetCannotJoinARunningWorld [

	| renderer |
	self addAvatarRenderedBy: SRTestRenderer flat.
	orchestrator setUp.
	renderer := SRTestRenderer xr.
	self addAvatarRenderedBy: renderer.
	orchestrator processPendingChanges.
	self assert: renderer events isEmpty.
	self deny: world isXR.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestratorTest >> testAHeadsetWindowKeepsItsMonitor [

	self addAvatarRenderedBy: SRTestRenderer flat; addAvatarRenderedBy: SRTestRenderer xr.
	self assert: orchestrator windowMonitor isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testChangesBeforeTheStartAreLeftToTheSetUp [

	| renderer |
	renderer := SRTestRenderer flat.
	self addAvatarRenderedBy: renderer.
	orchestrator setUp; processPendingChanges.
	self assert: renderer events asArray = #(#setup).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:06'
}
SRRendererOrchestratorTest >> testHeadsetViewsRenderFirst [

	| desktop headset order |
	desktop := self addAvatarRenderedBy: SRTestRenderer flat.
	headset := self addAvatarRenderedBy: SRTestRenderer xr.
	orchestrator setUp.
	order := OrderedCollection new.
	orchestrator activeAvatarsDo: [:each | order add: each].
	self assert: order asArray = {headset. desktop}.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:36'
}
SRRendererOrchestratorTest >> testInvalidatingTheWorldClearsTheSharedCache [

	self assert: (world cacheAt: #resource ifAbsentPut: [#old]) = #old.
	world invalidateCache.
	self assert: (world cacheAt: #resource ifAbsentPut: [#new]) = #new.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testJoiningAndLeavingBetweenFramesCancelOut [

	| renderer desktop |
	self addAvatarRenderedBy: SRTestRenderer xr.
	orchestrator setUp.
	renderer := SRTestRenderer flat.
	desktop := self addAvatarRenderedBy: renderer.
	desktop remove.
	orchestrator processPendingChanges.
	self assert: renderer events isEmpty.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testLeavingAndRejoiningBetweenFramesKeepsTheRenderer [

	| renderer desktop |
	renderer := SRTestRenderer flat.
	desktop := self addAvatarRenderedBy: renderer.
	orchestrator setUp.
	desktop remove.
	world addChild: desktop.
	orchestrator processPendingChanges.
	self assert: renderer events asArray = #(#setup).
	self assert: (orchestrator isActive: renderer).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testNothingIsProcessedWithoutPendingChanges [

	| renderer |
	renderer := SRTestRenderer flat.
	self addAvatarRenderedBy: renderer.
	orchestrator setUp; processPendingChanges; processPendingChanges.
	self assert: renderer events asArray = #(#setup).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestratorTest >> testOnlyAFlatWindowGetsTheHighDpiFlag [

	| saved |
	saved := SRRaylibRendererFlat highDpiEnabled.
	self addAvatarRenderedBy: SRTestRenderer flat.
	[SRRaylibRendererFlat highDpiEnabled: true.
	self assert: orchestrator windowConfigFlags = RlConfigFlags flagWindowHighdpi.
	SRRaylibRendererFlat highDpiEnabled: false.
	self assert: orchestrator windowConfigFlags isNil.
	SRRaylibRendererFlat highDpiEnabled: true.
	self addAvatarRenderedBy: SRTestRenderer xr.
	self assert: orchestrator windowConfigFlags isNil]
		ensure: [SRRaylibRendererFlat highDpiEnabled: saved].
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:02'
}
SRRendererOrchestratorTest >> testRenderersDescribeTheWindowTheyWouldOpen [

	self assert: SRRaylibRendererXR new windowExtent = (2468 @ 2130).
	self assert: SRRaylibRendererXR new windowTitle = 'SqueakXR'.
	self assert: SRRaylibRendererFlat new windowExtent = (SRRaylibRendererFlat windowWidth @ SRRaylibRendererFlat windowHeight).
	self assert: SRRaylibRendererFlat new windowTitle = 'Squeak 3D World'.
	self assert: SRTestRenderer flat windowExtent isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRRendererOrchestratorTest >> testStartingNeedsARenderingAvatar [

	world addChild: (SRAvatar inputStrategy: SRDesktopInputStrategy new).
	self should: [orchestrator assertRenderable] raise: AssertionFailure.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testSwappingARendererReplacesItAtTheFrameBoundary [

	| old new desktop |
	old := SRTestRenderer flat.
	desktop := self addAvatarRenderedBy: old.
	orchestrator setUp.
	new := SRTestRenderer flat.
	desktop renderer: new.
	self assert: new events isEmpty.
	orchestrator processPendingChanges.
	self assert: old events asArray = #(#setup #shutdown).
	self assert: new events asArray = #(#setup).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:58'
}
SRRendererOrchestratorTest >> testTheHeadsetRendererOpensTheSharedWindow [

	| headset |
	self addAvatarRenderedBy: SRTestRenderer flat.
	headset := self addAvatarRenderedBy: SRTestRenderer xr.
	self assert: orchestrator firstViewRenderer == headset renderer.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:54'
}
SRRendererOrchestratorTest >> testTheInputStrategyMustFitTheRenderer [

	world addChild: (SRAvatar inputStrategy: SRDesktopInputStrategy new renderer: SRRaylibRendererXR new).
	self should: [orchestrator assertRenderable] raise: AssertionFailure.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:18'
}
SRRendererOrchestratorTest >> testTheWindowShowsTheDesktopViewBesideAHeadset [

	| headset desktop |
	headset := self addAvatarRenderedBy: SRTestRenderer xr.
	orchestrator setUp.
	self assert: orchestrator windowRenderer == headset renderer.
	desktop := self addAvatarRenderedBy: SRTestRenderer flat.
	orchestrator processPendingChanges.
	self assert: orchestrator windowRenderer == desktop renderer.
]
