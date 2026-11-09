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
		'hands',
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
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> activateBy: aHand [

	action ifNotNil: [action valueWithEnoughArguments: (Array with: self with: aHand)].
	self menu ifNotNil: [:menu |
		(self keepsMenuOpen or: [menu isSticky])
			ifTrue: [menu labelsChanged]
			ifFalse: [menu closeCascade]].
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
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRMenuItem >> grabTarget [
	"A row is not something you can move on its own, so grabbing one drags the menu."

	^ self menu ifNil: [super grabTarget].
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> hands [

	^ hands
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuItem >> hovered [

	^ hands notEmpty or: [self opensSubmenu]
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> initialize [

	super initialize.
	
	label := ''.
	hands := IdentitySet new.
	size := 14cm @ 2cm @ self class itemDepth.
	textField := SRTextField new
		text: label;
		color: self class textColorNormal;
		scale: 0.015 asVector3;
		rotation: SRTextField uprightRotation;
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
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:49'
}
SRMenuItem >> label: aString action: aBlock [
	label := aString.
	action := aBlock.
	textField text: aString.
	self layoutLabel.
]

{
	#category : #building,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:49'
}
SRMenuItem >> layoutLabel [
	"Sent from both #label:action: and #width:height: so the cascade order in
	SRMenu>>rebuild cannot leave the text positioned for a stale width."
	textField position: size x / -2 + 0.005 @ (size y / 2 - 0.002) @ (size z / 2 + 1mm).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 5/19/2026 11:25'
}
SRMenuItem >> menu [
	^ self parent
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> onButtonPress: anEvent [

	anEvent button = #trigger ifTrue: [self activateBy: anEvent hand].
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> onCursorEnter: anEvent [

	(hands includes: anEvent hand) ifTrue: [^ self].
	hands add: anEvent hand.
	self menu ifNotNil: [:menu | menu itemEntered: self].
]

{
	#category : #input,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> onCursorLeave: anEvent [

	hands remove: anEvent hand ifAbsent: [].
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> opensSubmenu [

	^ self menu notNil and: [self menu submenuItem == self]
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:37'
}
SRMenuItem >> renderOn: aSRRenderer [

	| highlighted transform |
	highlighted := self hovered.
	textField color: (highlighted
		ifTrue: [self class textColorHighlight]
		ifFalse: [self class textColorNormal]).
	transform := self globalTransform * (Matrix4x4 withScale: size).
	aSRRenderer
		renderPlainCubeTransformed: transform withColor: (highlighted
			ifTrue: [self class fillColorHighlight]
			ifFalse: [self class fillColorNormal]);
		renderWireCubeTransformed: transform withColor: (highlighted
			ifTrue: [self class wireColorHighlight]
			ifFalse: [self class wireColorNormal]).
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 14:36'
}
SRMenuItem >> takeHandsFrom: anItem [

	hands addAll: anItem hands.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/17/2026 17:49'
}
SRMenuItem >> width: w height: h [

	size x: w.
	size y: h.
	self layoutLabel.
]
