"
A labelled slab you can point at, for controls that must stay usable when the
world is too slow to open a menu in. A PluggableButtonMorph inside an
SRMorphPanel draws but never receives the click, which is why this is geometry
and an SRTextField rather than a Morph.
"
Class {
	#name : #SRActionSign,
	#superclass : #SRObject,
	#instVars : [
		'size',
		'textField',
		'action',
		'slabColor'
	],
	#category : #'SqueakXR-Benchmarks',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> action: aBlock [
	"Evaluated with the sign as its optional argument, inside the raycast traversal:
	anything that changes the object tree has to be deferred to the next frame."

	action := aBlock.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale * size / 2;
		rotation: self globalRotation;
		object: self.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> initialize [
	super initialize.
	size := 80cm @ 12cm @ 2cm.
	slabColor := Color r: 0.5 g: 0.05 b: 0.05.
	textField := SRTextField new
		text: '';
		color: Color white;
		scale: 0.012 asVector3;
		rotation: (Quaternion new radiansAngle: Float pi / 2 axis: Vector3 right);
		yourself.
	self addChild: textField.
	self label: ''.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:11'
}
SRActionSign >> label [
	^ textField text.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> label: aString [
	textField text: aString.
	textField position: size x / -2 + 2cm @ (size y / 2 - 1cm) @ (size z / 2 + 1mm).
]

{
	#category : #events,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> onRaycast: aSRRayIntersectionResult [
	action ifNotNil: [action valueWithEnoughArguments: {self}].
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> renderOn: aSRRenderer [
	| transform |
	transform := self globalTransform * (Matrix4x4 withScale: size).
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: slabColor;
		renderWireCubeTransformed: transform withColor: Color white.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> size [
	^ size.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> size: aVector3 [
	size := aVector3.
	self label: textField text.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:09'
}
SRActionSign >> slabColor: aColor [
	slabColor := aColor.
]
