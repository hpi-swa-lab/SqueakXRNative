"
A SRButterflyHalo is a halo consisting of rows of buttons above and below the center.

Instance Variables

"
Class {
	#name : #SRButterflyHalo,
	#superclass : #SRHalo,
	#instVars : [
		'label',
		'relXform',
		'mini'
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
	#'squeak_changestamp' : 'phkeese 11/3/2026 16:28'
}
SRButterflyHalo >> addHandles [ 

	| bottom top y |
	top := {
		SRHaloButton new
			text: 'Close';
			clickAction: [self close].
		SRHaloButton new
			text: 'Inspect';
			clickAction: [self target inspect].
	}.
	bottom := {
		SRHaloButton new
			text: 'Move';
			grabAction: [:button :hand | relXform := button globalTransform inverseTransformation * self target globalTransform.];
			dragAction: [:button :xform | 
				button globalTransform: xform.
				self target dragTo: xform * relXform];
			dropAction: [relXform := nil. self frozen: false].
		SRHaloButton new
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
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:39'
}
SRButterflyHalo >> initialize [

	super initialize.
	label := SRTextField new
		text: 'No Target';
		scale: 0.05 asVector3;
		position: 0@ -5cm@0;
		rotation: SRTextField uprightRotation.
	self addChild: label.
	mini := SRMiniView new
		scale: 0.1 asVector3.
	self addChild: mini.
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
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:50'
}
SRButterflyHalo >> target: anObject [

	label text: '', anObject.
	mini subtree: anObject.
	super target: anObject.
]
