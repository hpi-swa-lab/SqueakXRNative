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
