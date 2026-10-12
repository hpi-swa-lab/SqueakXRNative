Class {
	#name : #SRRingHalo,
	#superclass : #SRHalo,
	#instVars : [
		'label'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 16:28'
}
SRRingHalo >> addButtons: aList [

	"Add buttons in a ring-like fashoin around my center."
	| step position xform |
	step := 360 / aList size.
	xform := Quaternion angle: step axis: Vector3 forward.
	position := Vector3 up * 0.3.
	aList do: [:btn |
		btn position: position.
		self addChild: btn.
		position := xform rotateVector: position.
	]

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 16:27'
}
SRRingHalo >> addHandles [ 

	| buttons |
	buttons := OrderedCollection new.
	5 timesRepeat: [ buttons add: (SRCubeButton new
		text: 'AAAA') ].
	self addButtons: buttons.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 16:20'
}
SRRingHalo >> initialize [ 

	super initialize.
	
	label := SRTextField new
		scale: 0.1 asVector3;
		position: (0@ -0.2@0);
		yourself.
	self addChild: label.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 16:17'
}
SRRingHalo >> target: anObject [

	label text: '', anObject.
	^ super target: anObject
]
