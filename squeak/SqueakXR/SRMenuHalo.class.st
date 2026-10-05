"
A Halo using a simple menu floating in the world.

Instance Variables

"
Class {
	#name : #SRMenuHalo,
	#superclass : #SRHalo,
	#instVars : [
		'menu'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 9/28/2026 15:33'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 11:20'
}
SRMenuHalo >> buildMenu [ 

	"Start building the actual menu for this"
	menu addItem: 'Inspect' action: [ target inspect ].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/5/2026 18:32'
}
SRMenuHalo >> initialize [ 

	super initialize.
	menu := SRMenu new.
	self addChild: menu.
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
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:47'
}
SRMenuHalo >> moveToCenter [ 

	"Place ourselves in the view path between the camera and our center."
	| camPos toCenter |
	camPos := self world avatar camera globalTranslation.
	"Clamp our distance from the camera to 0.5m to avoid being too far away."
	toCenter := self center - camPos.
	toCenter length: (toCenter length min: 0.5).
	self globalTranslation: camPos + toCenter.

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 14:39'
}
SRMenuHalo >> open [ 
	self 
		moveToCenter;
		lookAtUser;
		buildMenu.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 9/29/2026 11:02'
}
SRMenuHalo >> renderOn: aRenderer [
	
	menu renderOn: aRenderer
]
