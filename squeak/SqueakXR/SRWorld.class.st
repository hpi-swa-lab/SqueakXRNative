Class {
	#name : #SRWorld,
	#superclass : #SRObject,
	#instVars : [
		'running',
		'renderer',
		'worldProcess',
		'needsSetup',
		'lastFrameTime',
		'isXR',
		'keyboardFocus',
		'ranStartScript',
		'avatar',
		'isFramePrepared',
		'gizmoPainter',
		'project',
		'i',
		'secondStart'
	],
	#classVars : [
		'Current',
		'KeyDict',
		'RenderFrame',
		'RunStartScriptInFlat'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRWorld class >> clearRenderFrame [

	RenderFrame := nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/16/2026 15:24'
}
SRWorld class >> createKeyDict [ 

	"A bug on ARMv8 Android causes a segfault if we create this dict in the keyDict method directly.
	A layer of indirection, like this method, fixes it."
	| keyDict |
	keyDict := {
		0 -> nil.
		39 -> $'.
		44 -> $,.
		45 -> $-.
		46 -> $..
		47 -> $/.
		48 -> $0.
		49 -> $1.
		50 -> $2.
		51 -> $3.
		52 -> $4.
		53 -> $5.
		54 -> $6.
		55 -> $7.
		56 -> $8.
		57 -> $9.
		59 -> $;.
		61 -> $=.
		65 -> $a.
		66 -> $b.
		67 -> $c.
		68 -> $d.
		69 -> $e.
		70 -> $f.
		71 -> $g.
		72 -> $h.
		73 -> $i.
		74 -> $j.
		75 -> $k.
		76 -> $l.
		77 -> $m.
		78 -> $n.
		79 -> $o.
		80 -> $p.
		81 -> $q.
		82 -> $r.
		83 -> $s.
		84 -> $t.
		85 -> $u.
		86 -> $v.
		87 -> $w.
		88 -> $x.
		89 -> $y.
		90 -> $z.
		91 -> $[.
		92 -> $\.
		93 -> $].
		96 -> $`.
		32 -> Character space.
		256 -> Character escape.
		257 -> Character return.
		258 -> Character tab.
		259 -> Character backspace.
		260 -> Character insert.
		261 -> Character delete.
		262 -> Character arrowRight.
		263 -> Character arrowLeft.
		264 -> Character arrowDown.
		265 -> Character arrowUp.
		266 -> Character pageUp.
		267 -> Character pageDown.
		268 -> Character home.
		269 -> Character end.
		280 -> nil "capsLock".
		281 -> nil "scroll_lock".
		282 -> nil "num_lock".
		283 -> nil "print_screen".
		284 -> nil "pause".
		290 -> nil "F1".
		291 -> nil "F2".
		292 -> nil "F3".
		293 -> nil "F4".
		294 -> nil "F5".
		295 -> nil "F6".
		296 -> nil "F7".
		297 -> nil "F8".
		298 -> nil "F9".
		299 -> nil "F10".
		300 -> nil "F11".
		301 -> nil "F12".
		340 -> nil "left_shift".
		341 -> nil "left_control".
		342 -> nil "left_alt".
		343 -> nil "left_super".
		344 -> nil "right_shift".
		345 -> nil "right_control".
		346 -> nil "right_alt".
		347 -> nil "right_super".
		348 -> nil "kb_menu".
		320 -> 0 "num0".
		321 -> 1 "num1".
		322 -> 2 "num2".
		323 -> 3 "num3".
		324 -> 4 "num4".
		325 -> 5 "num5".
		326 -> 6 "num6".
		327 -> 7 "num7".
		328 -> 8 "num8".
		329 -> 9 "num9".
		330 -> nil "numDec".
		331 -> $/ "numDiv".
		332 -> $* "numMul".
		333 -> $- "numSub".
		334 -> $+ "numAdd".
		335 -> Character return. 
	} as: Dictionary.

	keyDict addAll: ({
		0 -> nil.
		39 -> $".
		44 -> $<.
		45 -> $_.
		46 -> $>.
		47 -> $?.
		48 -> $).
		49 -> $!.
		50 -> $@.
		51 -> $#.
		52 -> $$.
		53 -> $%.
		54 -> $^.
		55 -> $&.
		56 -> $*.
		57 -> $(.
		59 -> $:.
		61 -> $+.
		65 -> $A.
		66 -> $B.
		67 -> $C.
		68 -> $D.
		69 -> $E.
		70 -> $F.
		71 -> $G.
		72 -> $H.
		73 -> $I.
		74 -> $J.
		75 -> $K.
		76 -> $L.
		77 -> $M.
		78 -> $N.
		79 -> $O.
		80 -> $P.
		81 -> $Q.
		82 -> $R.
		83 -> $S.
		84 -> $T.
		85 -> $U.
		86 -> $V.
		87 -> $W.
		88 -> $X.
		89 -> $Y.
		90 -> $Z.
		91 -> ${.
		92 -> $|.
		93 -> $}.
		96 -> $~.
		32 -> Character space.
		256 -> Character escape.
		257 -> Character return.
		258 -> Character tab.
		259 -> Character backspace.
		260 -> Character insert.
		261 -> Character delete.
		262 -> Character arrowRight.
		263 -> Character arrowLeft.
		264 -> Character arrowDown.
		265 -> Character arrowUp.
		266 -> Character pageUp.
		267 -> Character pageDown.
		268 -> Character home.
		269 -> Character end.
		280 -> nil "capsLock".
		281 -> nil "scroll_lock".
		282 -> nil "num_lock".
		283 -> nil "print_screen".
		284 -> nil "pause".
		290 -> nil "F1".
		291 -> nil "F2".
		292 -> nil "F3".
		293 -> nil "F4".
		294 -> nil "F5".
		295 -> nil "F6".
		296 -> nil "F7".
		297 -> nil "F8".
		298 -> nil "F9".
		299 -> nil "F10".
		300 -> nil "F11".
		301 -> nil "F12".
		340 -> nil "left_shift".
		341 -> nil "left_control".
		342 -> nil "left_alt".
		343 -> nil "left_super".
		344 -> nil "right_shift".
		345 -> nil "right_control".
		346 -> nil "right_alt".
		347 -> nil "right_super".
		348 -> nil "kb_menu".
		320 -> 0 "num0".
		321 -> 1 "num1".
		322 -> 2 "num2".
		323 -> 3 "num3".
		324 -> 4 "num4".
		325 -> 5 "num5".
		326 -> 6 "num6".
		327 -> 7 "num7".
		328 -> 8 "num8".
		329 -> 9 "num9".
		330 -> nil "numDec".
		331 -> $/ "numDiv".
		332 -> $* "numMul".
		333 -> $- "numSub".
		334 -> $+ "numAdd".
		335 -> Character return. 
	} collect: [:assoc | assoc key: assoc key + self shiftValueOffset]).
	
	^keyDict
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 16:43'
}
SRWorld class >> current [

	^ Current
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 16:46'
}
SRWorld class >> current: aSRWorld [

	Current := aSRWorld
]

{ #category : #'as yet unclassified' }
SRWorld class >> ensureRenderFrame: world deltaTime: deltaTime [

	^ RenderFrame
		ifNil: [
			RenderFrame := SRFrame
				world: world
				deltaTime: deltaTime]
		ifNotNil: [
			RenderFrame isOld: true]
]

{ #category : #'as yet unclassified' }
SRWorld class >> initialize [

	" self initialize "
	
	Smalltalk
		addToStartUpList: self;
		addToShutDownList: self.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 14:31'
}
SRWorld class >> keyDict [

	^ KeyDict ifNil: [
		KeyDict := self createKeyDict]
]

{ #category : #'as yet unclassified' }
SRWorld class >> keyFor: charCode shift: isShiftPressed [

	"see KeyboardKey in raylib.h"
	
	^ self keyDict at: (charCode + (isShiftPressed ifFalse: [0] ifTrue: [self shiftValueOffset]))
		ifAbsent: [nil]
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 16:43'
}
SRWorld class >> resetCurrent [

	Current := nil
]

{ #category : #'as yet unclassified' }
SRWorld class >> runStartScriptInFlat [
	<preference: 'Run Start Script in Flat'
		category: 'SqueakXR'
		description: 'Whether to run the start script in a flat (non-XR) environment'
		type: #Boolean>
	^ RunStartScriptInFlat ifNil: [RunStartScriptInFlat := true]
]

{ #category : #'as yet unclassified' }
SRWorld class >> runStartScriptInFlat: aBoolean [

	RunStartScriptInFlat := aBoolean
]

{ #category : #'as yet unclassified' }
SRWorld class >> shiftValueOffset [

	^ 1000
]

{ #category : #'as yet unclassified' }
SRWorld class >> shutDown [

	self allInstances do: [:world |
		world shutDown]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 10:13'
}
SRWorld class >> startUp: resuming [

	| worlds |
	worlds := self allInstances.
	worlds do: [:world | world startUp: resuming].
	
	(worlds noneSatisfy: [:world | world isRunning]) ifTrue: [
		(Smalltalk arguments includes: '--xr') ifTrue: [
			TranscriptStream redirectToStdOut: true.
			Transcript showln: 'Starting new XR world'.
			SRWorld new
				isXR: true;
				renderer: SRRaylibRendererXR new;
				start]].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/8/2026 16:18'
}
SRWorld >> adjustPreferences [

	self log.
	self isXR ifTrue: [
		"Display relativeUiScaleFactor: 1.0."
		UIManager openToolsAttachedToMouseCursor: false.
		"Disable the drop shadow, ensures that the size of a Morph texture is not affected by focus"
		Preferences disable: #menuAppearance3d.]
]

{ #category : #accessing }
SRWorld >> avatar [

	^ avatar
]

{ #category : #'as yet unclassified' }
SRWorld >> cacheAt: aSymbol ifAbsentPut: aBlock [

	^ self renderer cacheAt: aSymbol ifAbsentPut: aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:48'
}
SRWorld >> camera [

	^ self avatar camera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 14:55'
}
SRWorld >> completeFrame [

	isFramePrepared ifTrue: [
		self renderer completeFrame]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/6/2026 14:09'
}
SRWorld >> doOneCycle [

	| deltaTime startTime frame secondCurrent secondDelta |
	startTime := DateAndTime now.
	deltaTime := (startTime - lastFrameTime) asNanoSeconds / 1000000.
	lastFrameTime := startTime.
	
	secondStart ifNil: [secondStart := DateAndTime now].
	secondCurrent := DateAndTime now.
	secondDelta := (secondCurrent - secondStart).
	secondDelta > 10 seconds ifTrue: [
		secondStart := DateAndTime now.
		Transcript showln: '=------ FPS: ', Raylib getFPS asString].
	
	frame := self class ensureRenderFrame: self deltaTime: deltaTime.
	frame process.
	self class clearRenderFrame.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/8/2026 16:17'
}
SRWorld >> enterMorphicProject [

	| stopButton |
	self log.
	project := SRMorphicProject new.
	Project current addDeferredUIMessage: [
		project
			enter: false
			revert: false
			saveForRevert: false].
	project waitForStart.
	
	stopButton := (SimpleButtonMorph newWithLabel: 'Stop')
		target: self;
		actionSelector: #stopWorldAndLeaveProject.
	project world addMorph: stopButton.
	stopButton position: 100 @ 100.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 11/11/2025 13:15'
}
SRWorld >> gizmoPainter [

	^ gizmoPainter
]

{ #category : #'as yet unclassified' }
SRWorld >> handleKeyPress: charCode [
	| isShiftDown |
	
	self keyboardFocus ifNil: [^ self].
	
	isShiftDown := ((Raylib isKeyDownKey: RlKeyboardKey keyLeftShift)
		or: [Raylib isKeyDownKey: RlKeyboardKey keyRightShift]).
	self keyboardFocus keyboardEvent: ((self class keyFor: charCode shift: isShiftDown)
		ifNil: [^ self])
]

{ #category : #'as yet unclassified' }
SRWorld >> initXrInput [

	<cdecl: SRXrInput* 'initXrInput' () module: 'squeakxrnative'>
	^ self externalCallFailed
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 11/11/2025 18:23'
}
SRWorld >> initialize [

	super initialize.
	
	running := false.
	needsSetup := false.
	ranStartScript := false.
	isFramePrepared := false.
	
	gizmoPainter := SRGizmoPainter new.
	self addChild: gizmoPainter.
	
	self
		isXR: false;
		renderer: SRRenderer rendererClass new. "TODO: decide this based on XRness"
	
]

{ #category : #'as yet unclassified' }
SRWorld >> initializeWorldProcess [
	
	self log.
	self renderer setup.
	self isXR ifTrue: [self initXrInput].
	Smalltalk at: #XRWorld put: self.
	self allDo: #onWorldStarted.
]

{ #category : #'as yet unclassified' }
SRWorld >> invalidateCache [

	self renderer clearCache.
	self cacheInvalidated.
]

{ #category : #accessing }
SRWorld >> isRunning [

	^ running
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'jl 4/29/2026 18:00'
}
SRWorld >> isRunning: aBoolean [

	running := aBoolean.
	running
		ifTrue: [self class current: self]
		ifFalse: []
]

{ #category : #'as yet unclassified' }
SRWorld >> isWorldObject [

	^ true
]

{ #category : #accessing }
SRWorld >> isXR [
	
	^ isXR
]

{ #category : #accessing }
SRWorld >> isXR: aBoolean [

	isXR := aBoolean
]

{ #category : #accessing }
SRWorld >> keyboardFocus [

	^ keyboardFocus
]

{ #category : #accessing }
SRWorld >> keyboardFocus: aSRObject [

	keyboardFocus := aSRObject
]

{ #category : #'as yet unclassified' }
SRWorld >> log [

	self log: String empty
]

{ #category : #'as yet unclassified' }
SRWorld >> log: aString [

	FileStream stdout
		nextPut: Character cr;
		nextPutAll: 'Log: ';
		nextPutAll: thisContext sender sender asString.
	aString ifNotEmpty: [
		FileStream stdout nextPutAll: ' - ';
		nextPutAll: aString].
	FileStream stdout flush.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 18:03'
}
SRWorld >> loop [

	["| profiling |
	
	profiling := true.
	[10 seconds wait. profiling := false] fork.
	MessageTally spyOn:
	[[profiling] whileTrue: [
		self doOneCycle. Processor yield]].
	Transcript showln: '================= PROFILING COMPLETE'."
	
	[self isRunning] whileTrue: [
		self doOneCycle. Processor yield]
	
	]
		on: Error
		do: [:error |
			error printVerboseOn: Transcript.
			error pass].
	self class resetCurrent.
]

{ #category : #'as yet unclassified' }
SRWorld >> pollActions [

	<cdecl: SRXrActionStates 'pollActions' () module: 'squeakxrnative'>
	^ self externalCallFailed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/1/2026 16:05'
}
SRWorld >> prepareFrame [

	isFramePrepared := self renderer prepareFrame: self avatar globalTransform.
	self avatar
		cameraPosition: self renderer cameraPosition asVector3
		target: self renderer cameraTarget asVector3
		up: self renderer cameraUp asVector3.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 09:40'
}
SRWorld >> processKeyInput [

	| keyValue keys |
	keys := OrderedCollection new.
	[(keyValue := Raylib getKeyPressed) = 0] whileFalse: [
		keys add: keyValue].
	
	keys ifNotEmpty: [
		keys do: [:k | self handleKeyPress: k]]
]

{ #category : #'as yet unclassified' }
SRWorld >> render: aSRObject [

	aSRObject renderOn: self renderer
]

{ #category : #accessing }
SRWorld >> renderer [

	^ renderer
]

{ #category : #accessing }
SRWorld >> renderer: aSRRenderer [

	renderer := aSRRenderer
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 17:11'
}
SRWorld >> resume [
	
	(worldProcess notNil and: [self isRunning]) ifTrue: [
		needsSetup ifTrue: [
			needsSetup := false.
			self initializeWorldProcess].
		worldProcess resume].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 18:12'
}
SRWorld >> runStartScript [

	self log.
	(self isXR not and: [self class runStartScriptInFlat not]) ifTrue: [^ self].
	ranStartScript := true.
	
	"self log: 'trying yaros...'."
	"methodMorser := MethodMorser new.
	methodMorserMorph := methodMorser open.
	methodMorser
		addSpace: (MorseCodeSpace forEnvironment: self environment);
		server: (MorseYarosServer forYaros:
			(YarosServer new
				connector: (YarosWebSocketClientConnector remoteName: 'localhost' port: 8082);
				yourself));
		startConnection.
	1 second wait.
	methodMorser
		addProjects: (methodMorser spaces first projectsWithAllNames: {#SqueakXR});
		startAutoSync."
	"yaros2 := YarosServer new
		""""connector: (YarosHTTPClientAndServerConnector remoteName: 'localhost' clientPort: 8083 serverPort: 8082);""""
		connector: (YarosWebSocketClientConnector remoteName: 'localhost' port: 8082)
		yourself.
	yaros2 startServer.
	yaros2 startClient.
	Smalltalk at: #TheYaros put: yaros2.
	self log: 'yaros connected'."
	
	"[10 seconds wait. Project current world imageForm writePNGfileNamed: 'world-', DateAndTime now asUnixTime asString, '.png'.
	Transcript showln: '----------------- WROTE IMAGE'] fork."
	
	self isXR ifFalse: [
		SRSceneTreeInspector openOn: self].
	
	self log: 'proceeding';
		"addChild: (SRMorphPanel new
			morph: methodMorserMorph;
			translation: -1 @ 1 @ -2.5);"
		addChild: (SRMorphPanel transcript
			translation: 1 @ 2 @ -2.5);
		addChild: (SRMorphPanel systemBrowser
			translation: 0 @ 1 @ -1.5);
		"addChild: (SRMorphPanel new
			morph: SystemBrowser default open dependents first;
			translation: 0 @ 2 @ -1.5);"
		addChild: (SRMorphPanel workspace
			translation: 1.5 @ 1 @ -1.5)";
		addChild: (SRMorphPanel new
			morph: SRSaveMorph new openInWorld;
			translation: -1.25 @ 1 @ -1.5)".
	
	self addChild: (SRFrameTimeGraph new translation: 1 @ 1 @ -1).
	
	self addChild: (SRMorphPanel new morph: ((SimpleButtonMorph new
		label: 'Profile'
		font: (StrikeFont familyName: #DefaultTextStyle size: 20))
		extent: 200 @ 100;
		target: [[MessageTally spyOnProcess: self worldProcess forMilliseconds: 5000] fork];
		actionSelector: #value))
	
	"{Color red. Color green. Color blue} withIndexDo: [:col :i |
	self addChild: (SRMorphPanel new
		morph: (Morph new
			extent: 50 asPoint;
			color: col);
		translation: i * 0.2 + 9 @ 9.5 @ 9.5)]"
]

{ #category : #'as yet unclassified' }
SRWorld >> shutDown [
	
	self suspend
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/28/2026 19:10'
}
SRWorld >> start [

	self class current ifNotNil: [self error: 'A world is already running!'].
	
	self log.
	self log: 'here'.
	self worldProcess: ([
		self log: 'add avatar'.
		self avatar ifNil: [
				avatar := SRAvatar new.
				self addChild: avatar].
		self adjustPreferences;
			initializeWorldProcess;
			enterMorphicProject;
			runStartScript.
		self isXR ifFalse: [
			(self allDescendants anySatisfy: [:obj | obj isKindOf: SRXRInputEmulator]) ifFalse: [
				self addChild: SRXRInputEmulator new]].
		lastFrameTime := DateAndTime now.
		self log: 'starting process'.
		self loop.
		self renderer shutdown
		] newProcess
			name: 'XR World Process';
			priority: Processor userSchedulingPriority).
	
	self isRunning: true.
	self resume
]

{ #category : #'as yet unclassified' }
SRWorld >> startUp: resuming [

	self log.
	resuming ifTrue: [
		self invalidateCache.
		needsSetup := resuming].
	self resume
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 16:59'
}
SRWorld >> stop [

	self invalidateCache;
		isRunning: false.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'jl 4/29/2026 18:07'
}
SRWorld >> stopAndWait [

	self stop.
	[self class current] whileNotNil: [Processor yield].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/4/2026 19:16'
}
SRWorld >> stopWorldAndLeaveProject [

	self stop.
	[project close]
		on: ProvideAnswerNotification
		do: [:noti |
			(noti messageText beginsWith: 'Do you really want to delete the project')
				ifTrue: [noti resume: true]
				ifFalse: [noti pass]].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 4/2/2026 16:53'
}
SRWorld >> suspend [

	worldProcess ifNotNil: [worldProcess suspend].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 4/29/2026 09:40'
}
SRWorld >> updateActions [

	self isXR ifTrue: [
		self changed: #actionsUpdated with: self pollActions].
	self processKeyInput
]

{ #category : #accessing }
SRWorld >> worldProcess [

	^ worldProcess
]

{ #category : #accessing }
SRWorld >> worldProcess: aProcess [

	worldProcess := aProcess
]
