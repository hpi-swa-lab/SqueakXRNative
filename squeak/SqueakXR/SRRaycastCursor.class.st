Class {
	#name : #SRRaycastCursor,
	#superclass : #SRCursor,
	#instVars : [
		'helpers'
	],
	#category : #'SqueakXR-Input'
}

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:02'
}
SRRaycastCursor >> initialize [ 

	super initialize.
	self 
		addChild: (SRCube new scale: 10cm asVector3);
		addChild: (SRCube new
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m).
]

{
	#category : #input,
	#'squeak_changestamp' : 'phkeese 9/14/2026 16:26'
}
SRRaycastCursor >> onInputsChanged: anInputState [

	anInputState trigger isJustPressed ifTrue: [ self castRay ].
]
