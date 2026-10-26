"
A SRButterflyHalo is a halo consisting of rows of buttons above and below the center.

Instance Variables

"
Class {
	#name : #SRButterflyHalo,
	#superclass : #SRHalo,
	#instVars : [
		'label',
		'relXform'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:01'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:18'
}
SRButterflyHalo class >> spacing [ 

	^15cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:40'
}
SRButterflyHalo >> addHandles [ 

	| bottom top y |
	top := {
		SRHaloHandle new
			text: 'Close';
			clickAction: [self close].
		SRHaloHandle new
			text: 'Inspect';
			clickAction: [self target inspect].
	}.
	bottom := {
		SRHaloHandle new
			text: 'Move';
			grabAction: [:hand :xform | relXform := xform inverseTransformation * self target globalTransform];
			dragAction: [:xform | self target dragTo: xform * relXform];
			dropAction: [:hand | relXform := nil].
		SRHaloHandle new
			text: 'Remove';
			clickAction: [self target remove. self close].
	}.
		
	y := 0. top do: [:handle | y := y + self class spacing. handle position: 0@y@0].
	y := 0. bottom do: [:handle | y := y - self class spacing. handle position: 0@y@0].
	self addChildren: top.	
	self addChildren: bottom.
	
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:30'
}
SRButterflyHalo >> dragTarget: xform [

	self target dragTo: xform
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:24'
}
SRButterflyHalo >> initialize [

	super initialize.
	label := SRTextField new
		centered: true;
		text: 'No Target';
		scale: 0.1 asVector3.
	self addChild: label.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:30'
}
SRButterflyHalo >> startMove [ 
	
	relXform := (self globalTransform inverseTransformation * self target globalTransform)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:30'
}
SRButterflyHalo >> stopMove [ 

	relXform := nil.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/26/2026 14:23'
}
SRButterflyHalo >> target: anObject [

	label text: '', anObject.
	super target: anObject.
]
