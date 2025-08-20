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
		'c',
		'lastKeypressTime',
		'lastKey'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRWorld class >> initialize [

	" self initialize "
	
	Smalltalk
		addToStartUpList: self;
		addToShutDownList: self.
]

{ #category : #'as yet unclassified' }
SRWorld class >> shutDown: quitting [

	self allInstances do: [:world |
		world shutDown: quitting]
]

{ #category : #'as yet unclassified' }
SRWorld class >> startUp [

	| worlds |
	worlds := self allInstances.
	worlds do: [:world | world resume].
	
	(worlds noneSatisfy: [:world | world isRunning]) ifTrue: [
		Smalltalk platformName = 'unix' "android (for now)" ifTrue: [
			SRWorld new
				isXR: true;
				renderer: SRRaylibRendererXR new;
				start]].
]

{ #category : #'as yet unclassified' }
SRWorld >> cacheAt: aSymbol ifAbsentPut: aBlock [

	^ self renderer cacheAt: aSymbol ifAbsentPut: aBlock
]

{ #category : #'as yet unclassified' }
SRWorld >> doOneCycle [

	| deltaTime startTime framePrepard keys |
	startTime := DateAndTime now.
	deltaTime := startTime - lastFrameTime.
	
	"Two issues with this.
	1) not resilient against errors
	2) quite inefficient because allDescendants constructs the array from scratch
	A morphic-like list approach would solve both."
	self allDescendants do: [:obj | obj step: deltaTime].
	
	framePrepard := self renderer prepareFrame.
	self isXR ifTrue: [
		self changed: #actionsUpdated with: self pollActions].
	keys := OrderedCollection new.
	[(c := Raylib getKeyPressed) = 0] whileFalse: [
		c = lastKey ifFalse: [keys add: c. lastKey := c.].
		]. 
	(Raylib isKeyPressedKey: RlKeyboardKey keyBackspace) ifTrue: [
		lastKey = 8 ifFalse: [keys add: 8. lastKey := 8]].
	keys ifNotEmpty: [
		keys do: [:k | self handleKeyPress: k].
		self allDo: [:o | (o class canUnderstand: #updateTexture)
			ifTrue: [o needsTextureUpdate]]].
	framePrepard ifTrue: [
		self renderSelfAndChildrenOn: self renderer.
		self renderer completeFrame].
	
	lastFrameTime := startTime.
]

{ #category : #'as yet unclassified' }
SRWorld >> handleKeyPress: charCode [
	| character event value keyCode keyValue buttons control |
	"startTime := DateAndTime now.
	deltaTime := - (lastKeypressTime ifNil: [DateAndTime yesterday]).
	 asMilliSeconds < 500 ifTrue: [^ self]."
	(charCode < 65 or: [charCode > 90]) ifTrue: [^ self].
	"lastKeypressTime := startTime."
	character := charCode asCharacter.
	((Raylib isKeyPressedKey: RlKeyboardKey keyLeftShift)
		or: [Raylib isKeyPressedKey: RlKeyboardKey keyRightShift])
			ifFalse: [character := character asLowercase].
	Transcript showln: Smalltalk windowSystemName.
	"Transcript showln: character;
		showln: character asUppercase;
		showln:EventSensor virtualKeyTable ."
	"value := 0."
	EventSensor installVirtualKeyTable.
	value := EventSensor virtualKeyTable keyAtValue: character asUppercase.
	
	control := (Raylib isKeyPressedKey: RlKeyboardKey keyLeftControl)
		or: [Raylib isKeyPressedKey: RlKeyboardKey keyRightControl].
	keyValue := control ifTrue: [115] ifFalse: [character asInteger].
	keyCode := control ifTrue: [1] ifFalse: [value].
	buttons := control ifTrue: [64] ifFalse: [0].
	
	"(Raylib isKeyPressedKey: RlKeyboardKey keyBackspace)"charCode = 8 ifTrue: [
		keyValue := 51.
		keyCode := 51].
	
	event := KeyboardEvent new
		setType: #keystroke
		buttons: buttons
		position: self currentHand position
		keyValue: keyValue
		keyCode: keyCode
		hand: self currentHand
		stamp: Sensor eventTimeNow.
	[self currentHand keyboardFocus keyStroke: event.]
		on: Error
		do: [:e | Transcript showln: 'error occurred during keystroke: ', e description asString].
	Transcript
		showln: 'keyboard input';
		showln: event;
		showln: self currentHand keyboardFocus.
	"self allDo: [:obj | (obj class canUnderstand: #needsTextureUpdate) ifTrue: [
			obj needsTextureUpdate]]"
]

{ #category : #'as yet unclassified' }
SRWorld >> initXrInput [

	<cdecl: SRXrInput* 'initXrInput' () module: 'squeakxrnative'>
	^ self externalCallFailed
]

{ #category : #initializing }
SRWorld >> initialize [

	super initialize.
	
	self
		isXR: false;
		renderer: SRRenderer rendererClass new. "TODO: decide this based on XRness"
	
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

{ #category : #'as yet unclassified' }
SRWorld >> pollActions [

	<cdecl: SRXrActionStates 'pollActions' () module: 'squeakxrnative'>
	^ self externalCallFailed
]

{ #category : #accessing }
SRWorld >> renderer [

	^ renderer
]

{ #category : #accessing }
SRWorld >> renderer: aSRRenderer [

	renderer := aSRRenderer
]

{ #category : #'as yet unclassified' }
SRWorld >> resume [

	(worldProcess notNil and: [self isRunning]) ifTrue: [
		needsSetup ifTrue: [
			needsSetup := false.
			self renderer setup.
			self allDo: #onWorldStarted.].
		worldProcess resume].
]

{ #category : #'as yet unclassified' }
SRWorld >> runStartScript [

	self isXR ifFalse: [^ self].
	
	self "addChild: SRAvatar new;"
		addChild: (SRMorphProjection new
			morph: (SystemBrowser default open dependents first)
			"morph: (RectangleMorph new
				borderWidth: 5; borderColor: Color red; color: Color blue);"
			"transform: ((Matrix4x4 withScale: 3 @ 1 @ 3)
			translatedBy: 0 @ 1 @ 0)")";
		addChild: (SRTranscriptWindow new
			rotation: -90 @ 0 @ 0;
			translation: 0 @ 1 @ -2)."
]

{ #category : #'as yet unclassified' }
SRWorld >> shutDown: quitting [

	self invalidateCache.
	needsSetup := quitting.
	self suspend.
]

{ #category : #'as yet unclassified' }
SRWorld >> start [

	self worldProcess: ([
		self isXR ifTrue: [
			self addChild: SRAvatar new].
		self renderer setup.
		self isXR ifTrue: [self initXrInput].
		self allDo: #onWorldStarted.
		self runStartScript.
		running := true.
		lastFrameTime := DateAndTime now.
		[self isRunning] whileTrue: [
			self doOneCycle. Processor yield.].
		self renderer shutdown
		] newProcess
			name: 'XR World Process';
			priority: Processor userSchedulingPriority).
	
	self worldProcess resume.
]

{ #category : #'as yet unclassified' }
SRWorld >> stop [

	self invalidateCache.
	running := false.
]

{ #category : #'as yet unclassified' }
SRWorld >> suspend [

	worldProcess ifNotNil: [worldProcess suspend].
]

{ #category : #accessing }
SRWorld >> worldProcess [

	^ worldProcess
]

{ #category : #accessing }
SRWorld >> worldProcess: aProcess [

	worldProcess := aProcess
]
