Class {
	#name : #SRInputDualAxisState,
	#superclass : #Object,
	#instVars : [
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
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:15'
}
SRInputDualAxisState class >> deadzoneSquared [ 

	^ self deadzone squared
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:33'
}
SRInputDualAxisState >> horizontal [

	^ horizontal > self class deadzone
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
	#'squeak_changestamp' : 'phkeese 9/14/2026 17:49'
}
SRInputDualAxisState >> initialize [

	horizontal := 0.
	vertical := 0.
	dirty := false.
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
	#'squeak_changestamp' : 'phkeese 9/15/2026 15:16'
}
SRInputDualAxisState >> value [

	^ self vector
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/14/2026 19:16'
}
SRInputDualAxisState >> vector [

	| v |
	"Need to build raw vector to have deadzone in the center and not along both axes."
	v := self realVector.
	^((v squaredDistanceTo: 0@0) < self class deadzoneSquared) 
		ifTrue: [ 0@0 ]
		ifFalse: [ v ]

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:38'
}
SRInputDualAxisState >> vertical [

	^ vertical > self class deadzone
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
