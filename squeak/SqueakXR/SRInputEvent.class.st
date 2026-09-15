"
A SRInputEvent is a general input event triggered on a target object by a hand.

Instance Variables

"
Class {
	#name : #SRInputEvent,
	#superclass : #Object,
	#instVars : [
		'target',
		'point',
		'hand',
		'handled'
	],
	#category : #'SqueakXR-Input',
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:16'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> hand [
	^ hand
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> hand: anObject [
	hand := anObject
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:38'
}
SRInputEvent >> handled [
	^ handled
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:38'
}
SRInputEvent >> handled: anObject [
	handled := anObject
]

{
	#category : #initialize,
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:38'
}
SRInputEvent >> initialize [ 

	handled := false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:34'
}
SRInputEvent >> isAnalogEvent [
	^false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:35'
}
SRInputEvent >> isButtonEvent [ 
	^false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:35'
}
SRInputEvent >> isCursorEnterEvent [
	^false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:35'
}
SRInputEvent >> isCursorLeaveEvent [
	^false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 20:35'
}
SRInputEvent >> isCursorMoveEvent [
	^false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> point [
	^ point
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> point: anObject [
	point := anObject
]

{
	#category : #printing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:44'
}
SRInputEvent >> printOn: aStream [

	aStream nextPutAll: 'an ', (self class name), '(';
		cr.
	self class allInstVarNames do: [ :iv |
		aStream 
			tab;
			nextPutAll: iv, ': ';
			print: (self perform: iv asSymbol);
			cr
	].
	aStream nextPutAll: ')'
]

{
	#category : #initialize,
	#'squeak_changestamp' : 'phkeese 9/15/2026 16:29'
}
SRInputEvent >> setFrom: anSRCursor [

	hand := anSRCursor hand.
	point := anSRCursor point.
	target := anSRCursor target.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> target [
	^ target
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:17'
}
SRInputEvent >> target: anObject [
	target := anObject
]
