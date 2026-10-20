Class {
	#name : #SRCubeButton,
	#superclass : #SRObject,
	#instVars : [
		'text',
		'cube',
		'onClick',
		'onDrag'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/20/2026 15:08'
}
SRCubeButton >> actOnInput: anEvent [

	anEvent isButtonEvent ifFalse: [^false].
	
	anEvent button = #trigger ifTrue: [
		self doClick: anEvent
	].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:30'
}
SRCubeButton >> collisionGeometry [

	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: cube globalScale / 2;
		rotation: self globalRotation;
		object: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:01'
}
SRCubeButton >> color [

	^ cube color
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:01'
}
SRCubeButton >> color: aColor [

	cube color: aColor
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:07'
}
SRCubeButton >> doClick: event [
	
	self onClick ifNotNil: [:handler |
		handler cull: event
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:28'
}
SRCubeButton >> handleInput: event [

	event isButtonEvent ifTrue: [	event pressed ifTrue: [self doClick: event] ].
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/15/2026 17:06'
}
SRCubeButton >> initialize [ 
	
	super initialize.
	
	cube := SRCube new.
	self addChild: cube.
	
	text := SRTextField new
		scale: 10cm asVector3;
		position: 0@0@2cm;
		centered: true.
	self addChild: text.
	self text: 'Cube Button'.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:02'
}
SRCubeButton >> onClick [
	^ onClick
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:02'
}
SRCubeButton >> onClick: aBlock [
	onClick := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:02'
}
SRCubeButton >> onDrag [
	^ onDrag
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 10/7/2026 15:02'
}
SRCubeButton >> onDrag: aBlock [
	onDrag := aBlock
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/7/2026 14:59'
}
SRCubeButton >> text [

	^ text text
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/15/2026 17:07'
}
SRCubeButton >> text: aString [
	
	| cubeScale |
	text text: aString.
	cubeScale := text textSize asVector3 * text scale.
	cubeScale z: 1cm.
	cube scale: cubeScale.
]
