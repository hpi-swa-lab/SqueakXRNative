Class {
	#name : #SRInputEventButton,
	#superclass : #SRInputEvent,
	#instVars : [
		'button',
		'pressed'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventButton >> button [
	^ button
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventButton >> button: anObject [
	button := anObject
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:34'
}
SRInputEventButton >> isButtonEvent [ 

	^true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventButton >> pressed [
	^ pressed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventButton >> pressed: anObject [
	pressed := anObject
]
