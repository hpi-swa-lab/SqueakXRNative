"
A Halo using a simple menu floating in the world.

Instance Variables

"
Class {
	#name : #SRMenuHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:33'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:09'
}
SRMenuHalo >> initialize [ 

	super initialize.
	self addChild: (SRHaloButton new
		text: 'Test Button').
	self addChild: (SRCube new
		scale: 5cm asVector3;
		color: Color green
	).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:43'
}
SRMenuHalo >> lookAtUser [ 

	self lookAt: self world avatar camera globalTranslation 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:01'
}
SRMenuHalo >> moveToTarget [ 

	self target ifNotNil: [:target | self globalTranslation: target globalTranslation ]. 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/28/2026 16:15'
}
SRMenuHalo >> step: deltaTime [ 

	self moveToTarget;
		lookAtUser.
]
