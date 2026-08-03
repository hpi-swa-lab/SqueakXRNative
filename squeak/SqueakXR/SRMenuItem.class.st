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
		'hovered',
		'size',
		'keepsMenuOpen'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:31'
}
SRMenuItem class >> fillColorHighlight [

	^ Color r: 0.25 g: 0.25 b: 0.4
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:31'
}
SRMenuItem class >> fillColorNormal [

	^ Color r: 0.1 g: 0.1 b: 0.2
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/16/2026 10:02'
}
SRMenuItem class >> itemDepth [

	^ 1cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:31'
}
SRMenuItem class >> textColorHighlight [

	^ Color yellow
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:31'
}
SRMenuItem class >> textColorNormal [

	^ Color white
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:32'
}
SRMenuItem class >> wireColorHighlight [

	^ Color yellow
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/3/2026 18:31'
}
SRMenuItem class >> wireColorNormal [

	^ Color r: 0.3 g: 0.3 b: 0.6
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> action [
	^ action
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'lege 7/3/2026 18:20'
}
SRMenuItem >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * size / 2;
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
	#'squeak_changestamp' : 'lege 7/3/2026 18:33'
}
SRMenuItem >> hovered: aBoolean [
	hovered = aBoolean ifTrue: [^ self].
	hovered := aBoolean.
	textField color: (hovered ifTrue: [self class textColorHighlight] ifFalse: [self class textColorNormal])
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 7/16/2026 09:55'
}
SRMenuItem >> initialize [

	super initialize.
	
	label := ''.
	hovered := false.
	size := 14cm @ 2cm @ self class itemDepth.
	textField := SRTextField new
		text: label;
		color: self class textColorNormal;
		scale: 0.015 asVector3;
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenuItem >> keepsMenuOpen [
	^ keepsMenuOpen ifNil: [false]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:28'
}
SRMenuItem >> keepsMenuOpen: aBoolean [
	keepsMenuOpen := aBoolean.
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
	#'squeak_changestamp' : 'lege 7/16/2026 10:01'
}
SRMenuItem >> label: aString action: aBlock [
	label := aString.
	action := aBlock.
	textField text: aString;
		position: size x / -2 + 0.005 @ (size y / 2 - 0.002) @ (size z / 2 + 1mm).
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
	#'squeak_changestamp' : 'MCPServer 8/3/2026 14:38'
}
SRMenuItem >> onRaycast: aSRRayIntersectionResult [
	"Actions may take the activated item as an optional argument."

	action ifNotNil: [action valueWithEnoughArguments: (Array with: self)].
	self keepsMenuOpen ifFalse: [
		self menu ifNotNil: [:m | m closeCascade]].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/3/2026 18:36'
}
SRMenuItem >> renderOn: aSRRenderer [
	| fillColor wireColor transform |
	self hovered
		ifTrue: [
			fillColor := self class fillColorHighlight.
			wireColor := self class wireColorHighlight]
		ifFalse: [
			fillColor := self class fillColorNormal.
			wireColor := self class wireColorNormal].
	
	transform := self globalTransform * (Matrix4x4 withScale: size).
	
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: fillColor;
		renderWireCubeTransformed: transform withColor: wireColor.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/3/2026 18:24'
}
SRMenuItem >> width: w height: h [

	size x: w.
	size y: h.
]
