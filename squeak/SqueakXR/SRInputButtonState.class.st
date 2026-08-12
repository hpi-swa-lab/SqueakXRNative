Class {
	#name : #SRInputButtonState,
	#superclass : #Object,
	#instVars : [
		'isJustPressed',
		'isPressed',
		'isJustReleased'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:13'
}
SRInputButtonState >> initialize [

	isPressed := false.
	isJustPressed := false.
	isJustReleased := false.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 16:49'
}
SRInputButtonState >> isJustPressed [

	^ isJustPressed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 16:50'
}
SRInputButtonState >> isJustReleased [

	^ isJustReleased
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 16:50'
}
SRInputButtonState >> isPressed [

	^ isPressed
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 16:49'
}
SRInputButtonState >> isPressed: aBoolean [

	isJustPressed := aBoolean and: isPressed not.
	isJustReleased := aBoolean not and: isPressed.
	isPressed := aBoolean.
]
