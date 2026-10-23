"
Assumes a Quest 3 controller.
"
Class {
	#name : #SRHandInputState,
	#superclass : #Object,
	#instVars : [
		'topButton',
		'bottomButton',
		'menuButton',
		'joystick',
		'trigger',
		'squeeze'
	],
	#classVars : [
		'GrabPressThreshold',
		'GrabReleaseThreshold'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'lege 8/5/2026 16:44'
}

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:17'
}
SRHandInputState class >> grabPressThreshold [
	<preference: 'Grab press threshold'
		category: 'SqueakXR'
		description: 'How far the grip must be squeezed to start a grab, from 0 to 1. The Index reports grip as force rather than travel, so a comfortable grab there peaks well below the value a Touch trigger reaches.'
		type: #Number>
	^ GrabPressThreshold ifNil: [GrabPressThreshold := 0.25]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHandInputState class >> grabPressThreshold: aNumber [

	GrabPressThreshold := aNumber.
	self allInstancesDo: [:each | each squeeze pressThreshold: aNumber].
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:17'
}
SRHandInputState class >> grabReleaseThreshold [
	<preference: 'Grab release threshold'
		category: 'SqueakXR'
		description: 'How far the grip must relax to end a grab, from 0 to 1. Keep it below the press threshold; the gap is what stops a grab flickering at the boundary.'
		type: #Number>
	^ GrabReleaseThreshold ifNil: [GrabReleaseThreshold := 0.15]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHandInputState class >> grabReleaseThreshold: aNumber [

	GrabReleaseThreshold := aNumber.
	self allInstancesDo: [:each | each squeeze releaseThreshold: aNumber].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> bottomButton [

	^ bottomButton
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:18'
}
SRHandInputState >> initialize [

	topButton := SRInputButtonState new.
	bottomButton := SRInputButtonState new.
	menuButton := SRInputButtonState new.
	joystick := SRInputDualAxisState new.
	trigger := SRInputFloatState new.
	squeeze := SRInputFloatState new
		pressThreshold: self class grabPressThreshold;
		releaseThreshold: self class grabReleaseThreshold;
		yourself.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> joystick [

	^ joystick
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> menuButton [

	^ menuButton
]

{
	#category : #printing,
	#'squeak_changestamp' : 'lege 8/6/2026 16:36'
}
SRHandInputState >> printOn: aStream [

	| joystickVector |
	super printOn: aStream.
	
	joystickVector := joystick vector.
	
	aStream nextPut: $(.
	{
		bottomButton isPressed asString.
		topButton isPressed asString.
		menuButton isPressed asString.
		trigger value printShowingDecimalPlaces: 2.
		squeeze value printShowingDecimalPlaces: 2.
		(joystickVector x printShowingDecimalPlaces: 2),'@',
		(joystickVector y printShowingDecimalPlaces: 2)} joinOn: aStream separatedBy: ', '.
	aStream nextPut: $).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> squeeze [

	^ squeeze
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:48'
}
SRHandInputState >> topButton [

	^ topButton
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> trigger [

	^ trigger
]

{
	#category : #updating,
	#'squeak_changestamp' : 'lege 8/6/2026 16:27'
}
SRHandInputState >> updateActionsCommon: actionStates handIndex: handIndex [

	self trigger updateValue: (actionStates triggers at: handIndex).
	self squeeze updateValue: (actionStates squeeze at: handIndex).
	self joystick
		horizontal: (actionStates thumbstickX at: handIndex);
		vertical: (actionStates thumbstickY at: handIndex).
]

{
	#category : #updating,
	#'squeak_changestamp' : 'lege 8/5/2026 17:54'
}
SRHandInputState >> updateActionsLeft: actionStates [

	self updateActionsCommon: actionStates handIndex: SRHand leftIndex.
	
	self topButton isPressed: actionStates y.
	self bottomButton isPressed: actionStates x.
	self menuButton isPressed: actionStates menu.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'lege 8/5/2026 17:55'
}
SRHandInputState >> updateActionsRight: actionStates [

	self updateActionsCommon: actionStates handIndex: SRHand rightIndex.
	
	self topButton isPressed: actionStates b.
	self bottomButton isPressed: actionStates a.
]

{
	#category : #updating,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRHandInputState >> updateDesktopTrigger: aTrigger squeeze: aSqueeze topButton: aBoolean [

	trigger updateValue: aTrigger.
	squeeze updateValue: aSqueeze.
	topButton isPressed: aBoolean.
]
