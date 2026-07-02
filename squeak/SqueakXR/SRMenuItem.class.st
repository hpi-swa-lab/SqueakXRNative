"
A single item in an SRMenu. Has a label, action block, and collision box for raycasting.
"
Class {
	#name : #SRMenuItem,
	#superclass : #SRObject,
	#instVars : [
		'label',
		'action',
		'textField',
		'highlightColor',
		'normalColor',
		'itemWidth',
		'itemHeight',
		'hovered'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> action [
	^ action
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:08'
}
SRMenuItem >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * (itemWidth / 2 @ (itemHeight / 2) @ 0.01);
		rotation: self globalRotation;
		object: self.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 18:30'
}
SRMenuItem >> hovered [
	^ hovered
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 18:30'
}
SRMenuItem >> hovered: aBoolean [
	hovered = aBoolean ifTrue: [^ self].
	hovered := aBoolean.
	textField color: (hovered ifTrue: [highlightColor] ifFalse: [normalColor])
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 10:52'
}
SRMenuItem >> initialize [
	super initialize.
	label := ''.
	normalColor := Color white.
	highlightColor := Color yellow.
	hovered := false.
	itemWidth := 0.14.
	itemHeight := 0.02.
	textField := SRTextField new
		text: label;
		color: normalColor;
		scale: 0.015 @ 0.015 @ 0.015;
		rotation: (Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right);
		yourself.
	self addChild: textField.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 17:30'
}
SRMenuItem >> isMenuItem [
	^ true.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> itemWidth: w height: h [
	itemWidth := w.
	itemHeight := h.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> label [
	^ label
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 6/2/2026 10:52'
}
SRMenuItem >> label: aString action: aBlock [
	label := aString.
	action := aBlock.
	textField text: aString;
		position: itemWidth / -2 + 0.005 @ (itemHeight / 2 - 0.002) @ 0.002.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> menu [
	^ self parent
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 7/2/2026 11:35'
}
SRMenuItem >> onRaycast: aSRRayIntersectionResult [
	action ifNotNil: [action value].
	self menu ifNotNil: [:m | m remove].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 17:29'
}
SRMenuItem >> renderOn: aSRRenderer [
	| fillColor wireColor |
	self hovered
		ifTrue: [
			fillColor := Color r: 0.25 g: 0.25 b: 0.4.
			wireColor := highlightColor]
		ifFalse: [
			fillColor := Color r: 0.1 g: 0.1 b: 0.2.
			wireColor := Color r: 0.3 g: 0.3 b: 0.6].
	Raylib rlPushMatrix;
		rlMultMatrixfMatf: self globalTransform transposed.
	Raylib
		drawCubePosition: (0 @ 0 @ 0) asRlVector
		width: itemWidth height: itemHeight length: 0.002
		color: fillColor asRlColor.
	Raylib
		drawCubeWiresPosition: (0 @ 0 @ 0) asRlVector
		width: itemWidth height: itemHeight length: 0.002
		color: wireColor asRlColor.
	Raylib rlPopMatrix.
]
