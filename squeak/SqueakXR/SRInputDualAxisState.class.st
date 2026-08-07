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
	#'squeak_changestamp' : 'phkeese 8/7/2026 16:17'
}
SRInputDualAxisState >> horizontal [

	^ horizontal
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
	#'squeak_changestamp' : 'phkeese 8/7/2026 16:17'
}
SRInputDualAxisState >> vector [
	| p |
	p := horizontal @ vertical.
	^ p r < self class deadzone ifTrue: [ 0@0 ] ifFalse: [ p ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/7/2026 16:17'
}
SRInputDualAxisState >> vertical [

	^ vertical
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:22'
}
SRInputDualAxisState >> vertical: aNumber [

	vertical := aNumber
]
