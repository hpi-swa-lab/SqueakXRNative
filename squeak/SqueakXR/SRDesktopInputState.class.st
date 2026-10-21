"
One snapshot of raylib's keyboard and mouse state for the flat/desktop renderer, taken once per frame.

Why this exists instead of calling Raylib directly from wherever input is needed:

raylib's EndDrawing ends with PollInputEvents, which does previousKeyState := currentKeyState and zeroes the key/char queue counts. So every raylib *edge* query (IsKeyPressed, IsKeyReleased, IsMouseButtonPressed, IsMouseButtonReleased) and both key queues are only valid for whatever glfwPollEvents itself collected -- they are destroyed by the next poll.

That is fine as long as glfwPollEvents is the only thing pumping the OS event queue. On X11 it is: GLFW owns its own Display connection. On Win32 and Cocoa it is not: the raylib window shares one event queue with the Squeak VM (PeekMessage(NULL, ...) / the shared NSApp queue), and both the VM's idle pump and Morphic's Sensor pump run inside the Squeak render loop. Input they deliver mid-frame lands in raylib's state and is then wiped by PollInputEvents before any Smalltalk code reads it -- which is why desktop SqueakXR loses most keystrokes and clicks on Windows and macOS but not under WSL.

The rules that follow, and that this class enforces:

1. Ask raylib only for *levels* (IsKeyDown, IsMouseButtonDown). A level is not destroyed by a competing pump. Derive press/release edges here, in Smalltalk, via SRInputButtonState.
2. Drain the key and char queues as late as possible in the frame -- immediately before endDrawing -- so that nothing an OS pump enqueued earlier in the frame is lost to the poll that follows.
3. Put the render loop's rescheduling point *after* endDrawing, never between the input reads and the poll.

Consumers read `SRDesktopInputState current`, whose contents belong to the previous frame's sample. Keys are tracked on first interrogation, so no fixed key list has to be maintained.
"
Class {
	#name : #SRDesktopInputState,
	#superclass : #Object,
	#instVars : [
		'keyStates',
		'mouseButtonStates',
		'pressedKeyCodes',
		'pressedChars',
		'mousePosition',
		'mouseDelta',
		'mouseWheel'
	],
	#classVars : [
		'Current'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState class >> current [

	^ Current ifNil: [Current := self new]
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState class >> modifierKeys [

	^ {RlKeyboardKey keyLeftShift. RlKeyboardKey keyRightShift.
		RlKeyboardKey keyLeftControl. RlKeyboardKey keyRightControl.
		RlKeyboardKey keyLeftAlt. RlKeyboardKey keyRightAlt.
		RlKeyboardKey keyLeftSuper. RlKeyboardKey keyRightSuper}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState class >> reset [

	Current := nil
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState >> initialize [

	super initialize.
	keyStates := Dictionary new.
	mouseButtonStates := Dictionary new.
	pressedKeyCodes := OrderedCollection new.
	pressedChars := OrderedCollection new.
	mousePosition := RlVector2 new.
	mouseDelta := RlVector2 new.
	mouseWheel := 0.0.
	self class modifierKeys do: [:each | self keyStateFor: each].
	#(0 1 2) do: [:each | self mouseButtonStateFor: each].
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isAltDown [

	^ (self isKeyDown: RlKeyboardKey keyLeftAlt)
		or: [self isKeyDown: RlKeyboardKey keyRightAlt]
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isControlDown [

	^ (self isKeyDown: RlKeyboardKey keyLeftControl)
		or: [self isKeyDown: RlKeyboardKey keyRightControl]
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isKeyDown: aKeyCode [

	^ (self keyStateFor: aKeyCode) isPressed
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> isKeyPressed: aKeyCode [

	^ (self keyStateFor: aKeyCode) isJustPressed
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isKeyReleased: aKeyCode [

	^ (self keyStateFor: aKeyCode) isJustReleased
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isKeyUp: aKeyCode [

	^ (self isKeyDown: aKeyCode) not
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isMouseButtonDown: aButtonIndex [

	^ (self mouseButtonStateFor: aButtonIndex) isPressed
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isMouseButtonPressed: aButtonIndex [

	^ (self mouseButtonStateFor: aButtonIndex) isJustPressed
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isMouseButtonReleased: aButtonIndex [

	^ (self mouseButtonStateFor: aButtonIndex) isJustReleased
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isShiftDown [

	^ (self isKeyDown: RlKeyboardKey keyLeftShift)
		or: [self isKeyDown: RlKeyboardKey keyRightShift]
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isSuperDown [

	^ (self isKeyDown: RlKeyboardKey keyLeftSuper)
		or: [self isKeyDown: RlKeyboardKey keyRightSuper]
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> keyStateFor: aKeyCode [

	^ keyStates at: aKeyCode ifAbsent: [
		| state |
		state := SRInputButtonState new.

		state isPressed: (Raylib isKeyDownKey: aKeyCode).
		state isPressed: (Raylib isKeyDownKey: aKeyCode).
		keyStates at: aKeyCode put: state]
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> morphicModifierBits [

	| bits |
	bits := 0.
	self isShiftDown ifTrue: [bits := bits bitOr: 2r0001].
	self isControlDown ifTrue: [bits := bits bitOr: 2r0010].
	self isSuperDown ifTrue: [bits := bits bitOr: 2r0100].
	self isAltDown ifTrue: [bits := bits bitOr: 2r1000].
	^ bits bitShift: MouseEvent numButtons
]

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState >> mouseButtonStateFor: aButtonIndex [

	^ mouseButtonStates at: aButtonIndex ifAbsent: [
		| state |
		state := SRInputButtonState new.
		state isPressed: (Raylib isMouseButtonDownButton: aButtonIndex).
		state isPressed: (Raylib isMouseButtonDownButton: aButtonIndex).
		mouseButtonStates at: aButtonIndex put: state]
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> mouseDelta [

	^ mouseDelta
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> mousePosition [

	^ mousePosition
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> mouseWheel [

	^ mouseWheel
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> pressedChars [

	^ pressedChars
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRDesktopInputState >> pressedKeyCodes [

	^ pressedKeyCodes
]

{
	#category : #sampling,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:01'
}
SRDesktopInputState >> sample [
	"Exactly once per frame, immediately before #endDrawing: raylib PollInputEvents runs there 
	and discards whatever has not been read."
	| code |
	pressedKeyCodes removeAll.
	pressedChars removeAll.
	[(code := Raylib getKeyPressed) = 0] whileFalse: [pressedKeyCodes add: code].
	[(code := Raylib getCharPressed) = 0] whileFalse: [pressedChars add: code].

	keyStates keysAndValuesDo: [:keyCode :state |
		state isPressed: (Raylib isKeyDownKey: keyCode)].
	mouseButtonStates keysAndValuesDo: [:button :state |
		state isPressed: (Raylib isMouseButtonDownButton: button)].

	mousePosition := Raylib getMousePosition.
	mouseDelta := Raylib getMouseDelta.
	mouseWheel := Raylib getMouseWheelMove.

]
