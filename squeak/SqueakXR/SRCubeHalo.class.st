Class {
	#name : #SRCubeHalo,
	#superclass : #SRHalo,
	#instVars : [
		'relativeTransform'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:08'
}
SRCubeHalo >> initialize [

	| step |
	super initialize.
	"Place 8 cubes in a ring".
	step := 360 / 8.
	0 to: 7 do: [:i | | pos xform |
		xform := Matrix4x4 identity rotatedBy: step * i around: Vector3 backward.
		pos := xform localPointToGlobal: Vector3 right.
		self addChild: (SRCubeButton new
			position: pos;
			onClick: [ Transcript showln: 'Pressed ', i ];
			text: '', i;
			yourself
		)
	].
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:57'
}
SRCubeHalo >> open [
	
	"Place ourselves along the line from the user's hand to the center."
	| toCenter |
	Transcript showln: 'Opening halo on ', self target.
	toCenter := (self center - self hand globalTranslation) normalized.
	self globalTranslation: self center + (toCenter * 0.5).
	self lookAt: self hand globalTranslation.
	relativeTransform := self target globalTransform inverseTransformation * self globalTransform 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 16:12'
}
SRCubeHalo >> step: deltaTime [ 

	self globalTransform: self target globalTransform * relativeTransform
]
