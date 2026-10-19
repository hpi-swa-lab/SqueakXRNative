Class {
	#name : #SRCubeTower,
	#superclass : #SRObject,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/8/2026 16:30'
}
SRCubeTower >> initialize [

	| base scale |
	super initialize.
	
	base := SRCube new
		scale: (1@10cm@1);
		color: Color red;
		yourself.
	self addChild: base.
	scale := (20cm@1@20cm).
	-1 to: 1 do: [:i |
		-1 to: 1 do: [:j |
			base addChild: (SRCube new
				scale: scale;
				color: Color blue;
				position: (i@3@j) * 0.3;
				yourself)
			]
		].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/13/2026 13:42'
}
SRCubeTower >> step: delta [

	"self gizmoSphere: Vector3 up size: 5cm color: Color black."
	| d |
	self gizmoPainter
		gizmoSphere: (self transform localDirToGlobal: Vector3 up)
		size: 5cm
		color: Color black.
	
	self children first gizmoPainter
		gizmoSphere: (self children first globalTransform localDirToGlobal: Vector3 up) normalize / 2
		size: 5cm
		color: Color red.
	
	self haltOnce.
	self children first children do: [:child |
		child gizmoPainter
			gizmoSphere: child globalTranslation +( (child globalTransform localDirToGlobal: Vector3 up) normalize / 4)
			size: 5cm
			color: Color blue.
		
		d := (child globalRotation rotateVector: Vector3 up) normalize.
			
		child gizmoPainter
			gizmoSphere: child globalTranslation +(d / 4)
			size: 5cm
			color: Color cyan.]
]
