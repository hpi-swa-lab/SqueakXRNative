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
		'itemHeight'
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
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:14'
}
SRMenuItem >> initialize [
	super initialize.
	label := ''.
	normalColor := Color white.
	highlightColor := Color yellow.
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
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:15'
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
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> onRaycast: aSRRayIntersectionResult [
	action ifNotNil: [action value].
	self menu ifNotNil: [:m | m close].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 13:12'
}
SRMenuItem >> renderOn: aSRRenderer [
	Raylib rlPushMatrix;
		rlMultMatrixfMatf: self globalTransform transposed.
	Raylib
		drawCubePosition: (0 @ 0 @ 0) asRlVector
		width: itemWidth height: itemHeight length: 0.002
		color: (Color r: 0.1 g: 0.1 b: 0.2) asRlColor.
	Raylib
		drawCubeWiresPosition: (0 @ 0 @ 0) asRlVector
		width: itemWidth height: itemHeight length: 0.002
		color: (Color r: 0.3 g: 0.3 b: 0.6) asRlColor.
	Raylib rlPopMatrix.
]
