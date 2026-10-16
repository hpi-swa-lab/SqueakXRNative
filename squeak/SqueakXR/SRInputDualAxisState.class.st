Class {
	#name : #SRInputDualAxisState,
	#superclass : #Object,
	#instVars : [
		'value',
		'buttonState',
		'vertical',
		'horizontal'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:33'
}
SRInputDualAxisState class >> deadzone [

	^ 0.1
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 10/16/2026 11:27'
}
SRInputDualAxisState >> horizontal [

	"#abs: the deadzone is a distance from centre, not a threshold. Comparing the
	signed value discarded every leftward and backward push as noise."

	^ horizontal abs > self class deadzone
		ifTrue: [horizontal]
		ifFalse: [0]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:23'
}
SRInputDualAxisState >> horizontal: aNumber [

	horizontal := aNumber
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:35'
}
SRInputDualAxisState >> initialize [

	horizontal := 0.
	vertical := 0.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:32'
}
SRInputDualAxisState >> normalizedVector [

	^ self vector normalized
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:39'
}
SRInputDualAxisState >> realHorizontal [

	^ horizontal
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:39'
}
SRInputDualAxisState >> realNormalizedVector [

	^ self realVector normalized
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:39'
}
SRInputDualAxisState >> realVector [

	^ horizontal @ vertical
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:39'
}
SRInputDualAxisState >> realVertical [

	^ vertical
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:40'
}
SRInputDualAxisState >> vector [

	^ self horizontal @ self vertical
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer 10/16/2026 11:27'
}
SRInputDualAxisState >> vertical [

	"See #horizontal: the deadzone is a distance from centre."

	^ vertical abs > self class deadzone
		ifTrue: [vertical]
		ifFalse: [0]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:22'
}
SRInputDualAxisState >> vertical: aNumber [

	vertical := aNumber
]
