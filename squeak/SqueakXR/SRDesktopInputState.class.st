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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState class >> current [
	"There is one raylib window per image, so one snapshot."

	^ Current ifNil: [Current := self new]
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState class >> modifierKeys [
	"Tracked from the start: they are read as a side condition of other events, so the
	first frame they matter must already have a valid level."

	^ {RlKeyboardKey keyLeftShift. RlKeyboardKey keyRightShift.
		RlKeyboardKey keyLeftControl. RlKeyboardKey keyRightControl.
		RlKeyboardKey keyLeftAlt. RlKeyboardKey keyRightAlt.
		RlKeyboardKey keyLeftSuper. RlKeyboardKey keyRightSuper}
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState class >> reset [
	"Drop the snapshot, so a newly opened window cannot inherit stale key levels and
	report a phantom press on its first frame."

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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> isKeyPressed: aKeyCode [
	"Down in this frame's sample and up in the previous one. Unlike raylib's
	IsKeyPressed, this edge is computed in the image and so cannot be destroyed by
	whoever else pumps the OS event queue."

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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:56'
}
SRDesktopInputState >> keyStateFor: aKeyCode [
	"Keys are tracked from their first interrogation onwards, so that no central list of
	interesting keys has to be kept in sync with the code that asks."

	^ keyStates at: aKeyCode ifAbsent: [
		| state |
		state := SRInputButtonState new.
		"Seed with the current level. Twice: the first #isPressed: would otherwise
		manufacture an edge out of a key that merely happens to be held right now."
		state isPressed: (Raylib isKeyDownKey: aKeyCode).
		state isPressed: (Raylib isKeyDownKey: aKeyCode).
		keyStates at: aKeyCode put: state]
]

{
	#category : #'querying-modifiers',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> morphicModifierBits [
	"The modifier half of a Morphic event's `buttons', already shifted past the mouse
	button bits -- i.e. what MouseEvent/KeyboardEvent expects in #buttons."

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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> mouseDelta [
	"An RlVector2, as GetMouseDelta returns it."

	^ mouseDelta
]

{
	#category : #'querying-mouse',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> mousePosition [
	"An RlVector2, as GetMousePosition returns it."

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
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> pressedChars [
	"The Unicode code points queued since the previous sample, in order; keyboard-layout
	correct and including auto-repeat, which #pressedKeyCodes is neither. Not consumed
	yet -- the keystroke path still goes through SRWorld class>>keyDict."

	^ pressedChars
]

{
	#category : #'querying-keyboard',
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> pressedKeyCodes [
	"The raylib key codes queued since the previous sample, in order. These are physical
	GLFW key codes, not characters."

	^ pressedKeyCodes
]

{
	#category : #sampling,
	#'squeak_changestamp' : 'MCPServer 10/13/2026 14:57'
}
SRDesktopInputState >> sample [
	"Read out everything raylib knows about input. Must be called at exactly one point
	per frame, and that point must be immediately before #endDrawing: endDrawing's last
	act is PollInputEvents, which empties both queues and collapses every press/release
	edge. See the class comment.

	Only levels are read from raylib; the edges are derived here."

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
