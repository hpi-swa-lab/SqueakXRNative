"
A second person joins the headset user: they get an avatar of their own, driven by mouse and keyboard in the mirror window, which shows their view instead of the left eye. Started with SRWorld>>startXRWithDesktopUser; #shutdown removes everything the mode added to the world.
"
Class {
	#name : #SRRaylibRendererXRWithDesktopUser,
	#superclass : #SRRaylibRendererXR,
	#instVars : [
		'desktopAvatar',
		'desktopEmulator',
		'desktopCamera',
		'headMarkers',
		'fullscreen'
	],
	#category : #'SqueakXR-Graphics-Renderer',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'desktop user',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> addDesktopUserTo: aWorld [
	"Before #start: once the world process runs, children may only change between frames."
	(aWorld allDescendants select: [:each | each isXRInputEmulator])
		do: [:each | each remove].
	desktopAvatar := SRAvatar new.
	(desktopAvatar camera children select: [:each | each isKindOf: SRSkyBox])
		do: [:each | each remove].
	desktopEmulator := SRXRInputEmulator new.
	desktopEmulator avatar: desktopAvatar.
	aWorld
		addChild: desktopAvatar;
		addChild: desktopEmulator.
	headMarkers := {
		self addHeadMarkerTo: desktopAvatar color: Color orange.
		self addHeadMarkerTo: aWorld avatar color: Color cyan}.
]

{
	#category : #'desktop user',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> addHeadMarkerTo: anAvatar color: aColor [
	"Inside its own cube a viewer sees only back faces, so each person sees just the other head."
	| head |
	head := SRCube new.
	head
		name: 'head marker';
		color: aColor;
		scale: 20cm asVector3;
		ignoreCollision: true.
	anAvatar camera addChild: head.
	^ head
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> completeFrame [
	"rlOpenXREnd leaves the swapchain texture, so the window can only be drawn after it."
	[[Raylib endMode3D] ensure: [Raylib rlOpenXREnd].
	self renderDesktopView]
		ensure: [Raylib endDrawing].
	1 milliSecond wait.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> desktopAvatar [

	^ desktopAvatar
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> desktopEmulator [

	^ desktopEmulator
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 14:05'
}
SRRaylibRendererXRWithDesktopUser >> isFullscreen [

	^ fullscreen == true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 14:05'
}
SRRaylibRendererXRWithDesktopUser >> mirrorAspect [
	"The window shows the desktop user's view, so it keeps the desktop window's shape."
	^ SRRaylibRendererFlat windowWidth / SRRaylibRendererFlat windowHeight
]

{
	#category : #'desktop user',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> removeDesktopUser [

	headMarkers ifNotNil: [headMarkers do: [:each | each remove]].
	desktopEmulator ifNotNil: [:each | each remove].
	desktopAvatar ifNotNil: [:each | each remove].
	headMarkers := nil.
	desktopEmulator := nil.
	desktopAvatar := nil.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> renderDesktopObject: anSRObject of: aWorld [

	[aWorld render: anSRObject]
		on: SRFrame exceptionSet
		do: [:error |
			anSRObject badRender: true.
			Transcript showln: 'desktop view: ', anSRObject printString, ': ', error description].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:57'
}
SRRaylibRendererXRWithDesktopUser >> renderDesktopView [

	| world xrCamera |
	desktopAvatar ifNil: [^ self].
	world := desktopAvatar world ifNil: [^ self].
	xrCamera := camera.
	camera := desktopCamera.
	[self
		clearLitShaders;
		updateCamera: desktopAvatar camera globalTransform.
	Raylib
		rlViewportX: 0 y: 0 width: Raylib getRenderWidth height: Raylib getRenderHeight;
		clearBackgroundColor: clearColor;
		beginMode3DCamera: camera.
	self renderSceneOf: world.
	Raylib endMode3D.
	self drawReticle.
	world gizmoPainter ifNotNil: [:painter | painter render2DOn: self]]
		ensure: [camera := xrCamera].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 18:53'
}
SRRaylibRendererXRWithDesktopUser >> renderSceneOf: aWorld [
	"SRFrame empties its render lists while it draws the headset view, so this view collects its own."
	| secondPass |
	secondPass := OrderedCollection new.
	aWorld allDo: [:each |
		each isRendering ifTrue: [
			each renderInSecondPass
				ifTrue: [secondPass add: each]
				ifFalse: [self renderDesktopObject: each of: aWorld]]].
	self renderOverlaysDo: [secondPass do: [:each | self renderDesktopObject: each of: aWorld]].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> screenCamera [

	^ desktopCamera
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'MCPServer (leo) 11/24/2026 18:47'
}
SRRaylibRendererXRWithDesktopUser >> setup [

	super setup.
	Raylib setWindowSizeWidth: SRRaylibRendererFlat windowWidth height: SRRaylibRendererFlat windowHeight.
	desktopCamera := RlCamera3D new
		position: (self class rlVector3For_1: 10 asVector3);
		target: self class rlVectorZero;
		up: (self class rlVector3For_2: Vector3 up);
		fovy: 45;
		projection: RlCameraProjection cameraPerspective.
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 13:42'
}
SRRaylibRendererXRWithDesktopUser >> shutdown [

	[self removeDesktopUser] ensure: [super shutdown].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 14:05'
}
SRRaylibRendererXRWithDesktopUser >> toggleFullscreen [
	"Borderless like SRRaylibRendererFlat, which also explains why."
	Raylib toggleBorderlessWindowed.
	fullscreen := self isFullscreen not.
]
