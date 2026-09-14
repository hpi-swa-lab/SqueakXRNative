Class {
	#name : #SRInputEventClick,
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
SRInputEventClick >> button [
	^ button
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventClick >> button: anObject [
	button := anObject
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:35'
}
SRInputEventClick >> isClickEvent [ 

	^true
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventClick >> pressed [
	^ pressed
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:18'
}
SRInputEventClick >> pressed: anObject [
	pressed := anObject
]
