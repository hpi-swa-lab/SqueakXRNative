Class {
	#name : #SRInputFloatState,
	#superclass : #Object,
	#instVars : [
		'value',
		'buttonState'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:19'
}
SRInputFloatState class >> pressThreshold [

	^ 0.9
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:19'
}
SRInputFloatState class >> releaseThreshold [

	^ 0.8
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 18:03'
}
SRInputFloatState >> initialize [

	value := 0.
	buttonState := SRInputButtonState new.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:20'
}
SRInputFloatState >> isJustPressed [

	^ buttonState isJustPressed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:20'
}
SRInputFloatState >> isJustReleased [

	^ buttonState isJustReleased
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:02'
}
SRInputFloatState >> isPressed [

	^ buttonState isPressed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:03'
}
SRInputFloatState >> updateValue: aNumber [

	| threshold |
	value := aNumber.
	
	threshold := buttonState isPressed
		ifTrue: [self class releaseThreshold]
		ifFalse: [self class pressThreshold].
	buttonState isPressed: value > threshold.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 18:02'
}
SRInputFloatState >> value [

	^ value
]
