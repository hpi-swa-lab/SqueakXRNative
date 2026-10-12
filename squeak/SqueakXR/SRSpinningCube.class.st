Class {
	#name : #SRSpinningCube,
	#superclass : #SRObject,
	#instVars : [
		'cube'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 17:20'
}
SRSpinningCube >> initialize [ 

	super initialize.
	
	self addChild: (cube := SRCube new
		scale: 20cm asVector3;
		color: (Color blue alpha: 0.5);
		yourself
	)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/12/2026 17:20'
}
SRSpinningCube >> step: delta [

	| rot turn dirs grot |
	turn := (36 * delta) asFloat.
	Transcript showln: delta asFloat.
	rot := Quaternion angle: turn axis: Vector3 one normalized.
	self globalTranslation: (self globalTranslation + (Vector3 right * 0.1 * delta)).
	self globalTransform: (self globalTransform * rot asMatrix4x4).
	
	dirs := {Vector3 up. Vector3 right. Vector3 forward}.
	
	"Draw the correct basis using our transform in gray."
	dirs do: [:dir |
		self gizmoPainter gizmoLine: self globalTranslation to: (self globalTransform localPointToGlobal: dir) color: Color gray ]. 
	
	"Draw the flawed basis using our global rotation in red."
	grot := self globalRotation.
	dirs do: [:dir | | end |
		end := (grot rotateVector: dir) + self globalTranslation.
		self gizmoPainter gizmoLine: self globalTranslation to: end color: Color red.
	].

	cube collisionGeometry drawGizmoOn: self gizmoPainter colored: Color green.
]
