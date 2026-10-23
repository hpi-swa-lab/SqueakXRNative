Class {
	#name : #SRInputFloatState,
	#superclass : #Object,
	#instVars : [
		'value',
		'buttonState',
		'pressThreshold',
		'releaseThreshold'
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
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRInputFloatState >> pressThreshold [

	^ pressThreshold ifNil: [self class pressThreshold]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:17'
}
SRInputFloatState >> pressThreshold: aNumber [

	pressThreshold := aNumber.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRInputFloatState >> releaseThreshold [

	^ releaseThreshold ifNil: [self class releaseThreshold]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:17'
}
SRInputFloatState >> releaseThreshold: aNumber [

	releaseThreshold := aNumber.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 10/14/2026 13:17'
}
SRInputFloatState >> updateValue: aNumber [

	| threshold |
	value := aNumber.
	
	threshold := buttonState isPressed
		ifTrue: [self releaseThreshold]
		ifFalse: [self pressThreshold].
	buttonState isPressed: value > threshold.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 18:02'
}
SRInputFloatState >> value [

	^ value
]
