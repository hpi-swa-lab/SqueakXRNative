Class {
	#name : #SRDirectHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:28'
}
SRDirectHalo >> addHandles [ 

	self addChild: (SRHaloButton new
		text: 'Move';
		color: Color brown;
		stepAction: [:btn | btn 
			globalTranslation: self target globalTranslation;
			faceCamera
		];
		dragAction: [:btn :xform | self target globalTranslation: xform translation]
	).
	self addChild: (SRRotationGizmo new scale: 0.25 asVector3).
]
