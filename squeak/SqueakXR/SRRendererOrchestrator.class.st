"
Decides when the renderers of a world's avatars set up, draw and shut down.
"
Class {
	#name : #SRRendererOrchestrator,
	#superclass : #Object,
	#instVars : [
		'world',
		'isFramePrepared',
		'activeRenderers',
		'pendingSetups',
		'pendingShutdowns',
		'cache'
	],
	#category : #'SqueakXR-Graphics-Renderer',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:24'
}
SRRendererOrchestrator class >> for: aWorld [

	^ self new
		world: aWorld;
		yourself
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:11'
}
SRRendererOrchestrator >> activate: aRenderer [

	aRenderer setup.
	activeRenderers add: aRenderer.
]

{
	#category : #enumerating,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> activeAvatarsDo: aBlock [

	self viewAvatarsDo: [:each | (activeRenderers includes: each renderer) ifTrue: [aBlock value: each]].
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> adoptWindowFor: aRenderer [
	"A renderer that is going to show the shared window gives it its size, unless it already has that size."

	| shown extent |
	extent := aRenderer windowExtent ifNil: [^ self].
	shown := self windowRenderer.
	(shown isNil or: [aRenderer windowPriority > shown windowPriority]) ifFalse: [^ self].
	(Raylib getScreenWidth = extent x and: [Raylib getScreenHeight = extent y]) ifTrue: [^ self].
	Raylib setWindowSizeWidth: extent x height: extent y.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRRendererOrchestrator >> assertRenderable [

	| rendering |
	rendering := world avatars select: [:each | each renderer rendersViews].
	self assert: rendering notEmpty description: 'Starting needs an avatar with a renderer'.
	self
		assert: (rendering count: [:each | each renderer isXR]) <= 1
		description: 'Only one avatar can render to the headset'.
	self
		assert: (rendering count: [:each | each renderer isXR not]) <= 1
		description: 'Only one avatar can render to the window'.
	rendering do: [:each |
		self
			assert: (each inputStrategy notNil and: [each isControllerDriven = each renderer isXR])
			description: 'A rendering avatar needs an input strategy fitting its renderer'].
]

{
	#category : #frame,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRRendererOrchestrator >> beginFrame [

	Raylib beginDrawing.
	isFramePrepared := true.
]

{
	#category : #cache,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:23'
}
SRRendererOrchestrator >> cacheAt: aKey ifAbsentPut: aBlock [
	"GPU resources, shared by all renderers, which draw into the same GL context."

	^ cache at: aKey ifAbsentPut: aBlock
]

{
	#category : #cache,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:23'
}
SRRendererOrchestrator >> clearCache [

	cache removeAll.
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:17'
}
SRRendererOrchestrator >> clearPendingChanges [

	pendingSetups := IdentitySet new.
	pendingShutdowns := IdentitySet new.
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> deactivate: aRenderer [

	activeRenderers remove: aRenderer.
	aRenderer shutdown.
]

{
	#category : #frame,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRRendererOrchestrator >> endFrame [
	"Last thing before #endDrawing: raylib PollInputEvents runs there and empties both key queues."

	isFramePrepared ifFalse: [^ self].
	isFramePrepared := false.
	SRDesktopInputState current sample.
	Raylib endDrawing.
	1 milliSecond wait.
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:57'
}
SRRendererOrchestrator >> firstViewRenderer [

	self viewAvatarsDo: [:each | ^ each renderer].
	^ nil
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> hasHeadsetView [

	self viewAvatarsDo: [:each | each renderer isXR ifTrue: [^ true]].
	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> hasXRRenderer [

	^ activeRenderers anySatisfy: [:each | each isXR]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> isActive: aRenderer [

	^ activeRenderers includes: aRenderer
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> openWindow [
	"Before rlOpenXRSetup, which binds the GL context InitWindow creates."

	Raylib isWindowReady ifTrue: [^ self].
	self windowExtent ifNil: [^ self].
	self windowConfigFlags ifNotNil: [:flags | Raylib setConfigFlags: flags].
	Raylib initWindowWidth: self windowExtent x height: self windowExtent y title: self windowTitle.
	self windowMonitor ifNotNil: [:monitor | Raylib setWindowMonitor: monitor].
]

{
	#category : #frame,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> pollEvents [

	self activeAvatarsDo: [:each | each renderer pollEventsAndWaitForFrame].
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:01'
}
SRRendererOrchestrator >> processPendingChanges [
	"On the world process between frames, which owns the GL context. XR renderers only start with the world, see SRWorld>>initializeWorldProcess."

	(pendingSetups isEmpty and: [pendingShutdowns isEmpty]) ifTrue: [^ self].
	self renderers: pendingShutdowns inShutdownOrderDo: [:each | self deactivate: each].
	pendingSetups do: [:each | each canStartWhileRunning ifTrue: [
		self adoptWindowFor: each.
		self activate: each]].
	self clearPendingChanges.
]

{
	#category : #cache,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:23'
}
SRRendererOrchestrator >> removeCacheAt: aKey [

	cache removeKey: aKey ifAbsent: [].
]

{
	#category : #frame,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:31'
}
SRRendererOrchestrator >> renderFrame: aFrame [

	| windowRenderer |
	windowRenderer := self windowRenderer.
	self activeAvatarsDo: [:each |
		SRRenderingAvatarVariable value: each during: [
			each renderer
				environment: world visualEnvironment lights: world lightsBuffer;
				render: aFrame from: each showingWindow: each renderer == windowRenderer painter: world gizmoPainter]].
]

{
	#category : #avatars,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:17'
}
SRRendererOrchestrator >> rendererJoined: aRenderer [
	"Takes effect at the next frame boundary, see #processPendingChanges."

	aRenderer rendersViews ifFalse: [^ self].
	(pendingShutdowns includes: aRenderer) ifTrue: [^ pendingShutdowns remove: aRenderer].
	(self isActive: aRenderer) ifFalse: [pendingSetups add: aRenderer].
]

{
	#category : #avatars,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:17'
}
SRRendererOrchestrator >> rendererLeft: aRenderer [
	"Takes effect at the next frame boundary, see #processPendingChanges."

	(pendingSetups includes: aRenderer) ifTrue: [^ pendingSetups remove: aRenderer].
	(self isActive: aRenderer) ifTrue: [pendingShutdowns add: aRenderer].
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:17'
}
SRRendererOrchestrator >> renderers: aCollection inShutdownOrderDo: aBlock [
	"OpenXR releases GL resources, so it goes before anything that could leave the context."

	(aCollection select: [:each | each isXR]) do: aBlock.
	(aCollection reject: [:each | each isXR]) do: aBlock.
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> setUp [

	self clearPendingChanges.
	activeRenderers := IdentitySet new.
	self openWindow.
	self viewAvatarsDo: [:each |
		self adoptWindowFor: each renderer.
		self activate: each renderer].
]

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:17'
}
SRRendererOrchestrator >> shutDown [
	"Renderers release theirs while the window, and with it the GL context, still exists."

	self renderers: activeRenderers copy inShutdownOrderDo: [:each | self deactivate: each].
	self clearPendingChanges.
	Raylib isWindowReady ifTrue: [Raylib closeWindow].
]

{
	#category : #enumerating,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> viewAvatarsDo: aBlock [
	"Headset views first: the window is only drawn to outside of an XR frame."

	world avatarsDo: [:each | (each renderer rendersViews and: [each renderer isXR]) ifTrue: [aBlock value: each]].
	world avatarsDo: [:each | (each renderer rendersViews and: [each renderer isXR not]) ifTrue: [aBlock value: each]].
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> windowConfigFlags [
	"The preference only applies to a flat window."

	^ (self hasHeadsetView not and: [SRRaylibRendererFlat highDpiEnabled])
		ifTrue: [RlConfigFlags flagWindowHighdpi]
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> windowExtent [
	"Of the first renderer set up, a headset's if there is one."

	^ self firstViewRenderer ifNotNil: [:renderer | renderer windowExtent]
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> windowMonitor [
	"The preference only applies to a flat window; a headset's mirror is placed by SRRaylibRenderer>>placeMirrorWindowOnce. Asks for the monitors, so only once the window is open."

	self hasHeadsetView ifTrue: [^ nil].
	^ Raylib getMonitorCount < SRRenderer startMonitor
		ifTrue: [0]
		ifFalse: [SRRenderer startMonitor]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 17:05'
}
SRRendererOrchestrator >> windowRenderer [

	| best |
	activeRenderers do: [:each |
		(best isNil or: [each windowPriority > best windowPriority]) ifTrue: [best := each]].
	^ best
]

{
	#category : #window,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:06'
}
SRRendererOrchestrator >> windowTitle [

	^ self firstViewRenderer ifNotNil: [:renderer | renderer windowTitle]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 18:24'
}
SRRendererOrchestrator >> world: aWorld [

	world := aWorld.
	isFramePrepared := false.
	activeRenderers := IdentitySet new.
	cache := Dictionary new.
	self clearPendingChanges.
]
