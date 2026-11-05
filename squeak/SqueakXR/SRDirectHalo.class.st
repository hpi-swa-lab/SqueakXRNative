Class {
	#name : #SRDirectHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:39'
}
SRDirectHalo >> addHandles [ 

	self addChild: (SRHaloButton new
		text: 'Move';
		color: Color brown;
		stepAction: [:btn | btn 
			globalTranslation: self target globalTranslation;
			lookAtCamera
		];
		dragAction: [:btn :xform | self target globalTranslation: xform translation]
	).
	self addChild: (SRRotationHandle new
		scale: 0.5 asVector3
	).	
]
