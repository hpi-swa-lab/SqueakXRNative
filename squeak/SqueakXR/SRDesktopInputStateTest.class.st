Class {
	#name : #SRDesktopInputStateTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Input'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> holding: keyCodes [
	| state |
	state := SRDesktopInputState new.
	SRDesktopInputState modifierKeys do: [:each |
		(state keyStateFor: each) isPressed: (keyCodes includes: each)].
	^ state
]

{
	#category : #helpers,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> keystrokeHolding: keyCodes controlToCommand: controlToCommand altToOption: altToOption [
	^ KeyboardEvent new
		setType: #keystroke
		buttons: ((self holding: keyCodes)
			morphicModifierBitsControlToCommand: controlToCommand
			altToOption: altToOption)
		position: 0 @ 0
		keyValue: $c asInteger
		keyCode: $c asInteger
		hand: nil
		stamp: 0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> testAltIsCommandAndOptionWhenMappedToOption [
	| event |
	event := self
		keystrokeHolding: {RlKeyboardKey keyLeftAlt}
		controlToCommand: true
		altToOption: true.
	self
		assert: event commandKeyPressed;
		assert: event optionKeyPressed;
		deny: event controlKeyPressed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> testAltIsCommandWhenNotMapped [
	| event |
	event := self
		keystrokeHolding: {RlKeyboardKey keyLeftAlt}
		controlToCommand: true
		altToOption: false.
	self
		assert: event commandKeyPressed;
		deny: event optionKeyPressed;
		deny: event controlKeyPressed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> testControlIsCommandAndControlWhenMappedToCommand [
	| event |
	event := self
		keystrokeHolding: {RlKeyboardKey keyLeftControl}
		controlToCommand: true
		altToOption: true.
	self
		assert: event commandKeyPressed;
		assert: event controlKeyPressed;
		deny: event optionKeyPressed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> testControlIsOnlyControlWhenNotMapped [
	| event |
	event := self
		keystrokeHolding: {RlKeyboardKey keyRightControl}
		controlToCommand: false
		altToOption: true.
	self
		deny: event commandKeyPressed;
		assert: event controlKeyPressed.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'jl-MCPServer 11/20/2026 11:34'
}
SRDesktopInputStateTest >> testShiftIsShift [
	| event |
	event := self
		keystrokeHolding: {RlKeyboardKey keyLeftShift}
		controlToCommand: true
		altToOption: true.
	self
		assert: event shiftPressed;
		deny: event commandKeyPressed;
		deny: event controlKeyPressed.
]
