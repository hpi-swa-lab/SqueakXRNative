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
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'lege 8/5/2026 16:44'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:49'
}
SRHandInputState >> bottomButton [

	^ bottomButton
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'lege 8/5/2026 17:46'
}
SRHandInputState >> initialize [

	topButton := SRInputButtonState new.
	bottomButton := SRInputButtonState new.
	menuButton := SRInputButtonState new.
	joystick := SRInputDualAxisState new.
	trigger := SRInputFloatState new.
	squeeze := SRInputFloatState new.
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
