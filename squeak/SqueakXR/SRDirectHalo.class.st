Class {
	#name : #SRDirectHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:45'
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
	self addChild: (SRRotationHandle new
		scale: 0.5 asVector3
	).	
]
