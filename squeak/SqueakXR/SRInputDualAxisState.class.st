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
	#'squeak_changestamp' : 'phkeese 8/10/2026 11:29'
}
SRInputDualAxisState class >> deadzoneSquared [
	^ self deadzone squared 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/10/2026 11:28'
}
SRInputDualAxisState >> horizontal [

	^ horizontal squared > self class deadzoneSquared
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
	#'squeak_changestamp' : 'phkeese 8/10/2026 11:32'
}
SRInputDualAxisState >> vector [
	| rv |
	rv := self realVector .
	^ (rv dotProduct: rv) > self class deadzoneSquared
		ifTrue: [ rv ]
		ifFalse: [ 0@0 ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/10/2026 11:29'
}
SRInputDualAxisState >> vertical [

	^ vertical squared > self class deadzoneSquared
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
