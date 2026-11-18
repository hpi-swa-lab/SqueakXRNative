Class {
	#name : #SRCube,
	#superclass : #SRObject,
	#instVars : [
		'color',
		'drawWires'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:55'
}
SRCube class >> color: aColor from: start to: end thickness: aNumber [

	^ (self color: aColor size: 1 asVector3 at: start)
		beamFrom: start to: end thickness: aNumber;
		yourself
]

{
	#category : #'instance creation',
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:55'
}
SRCube class >> color: aColor size: aVector3 at: aPosition [

	^ self new
		color: aColor;
		scale: aVector3;
		translation: aPosition;
		ignoreCollision: true;
		yourself
]

{
	#category : #'xr menu',
	#'squeak_changestamp' : 'MCPServer 8/3/2026 13:35'
}
SRCube class >> xrMenuSpawn: aMenu [
	<xrMenu: #(world spawn) label: 'Cube' priority: 100>
	| cube |
	cube := self new
		position: aMenu position;
		scale: 30cm asVector3;
		yourself.
	aMenu world addChild: cube.
	^ cube
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:55'
}
SRCube >> beamFrom: start to: end thickness: aNumber [

	| direction up |
	direction := (end - start) normalized.
	up := (direction cross: Vector3 right) length < 0.01
		ifTrue: [Vector3 up]
		ifFalse: [Vector3 right].
	self localTransform: (Matrix4x4 objectLookAt: end from: start + end / 2 up: up)
		* (Matrix4x4 withScale: aNumber @ aNumber @ (start distanceTo: end))
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 10/8/2026 17:49'
}
SRCube >> collisionGeometry [ 

	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale / 2.0;
		rotation: self globalRotation;
		object: self
]

{ #category : #accessing }
SRCube >> color [

	^ color
]

{ #category : #accessing }
SRCube >> color: aColor [

	color := aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCube >> drawWires [
	^ drawWires.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCube >> drawWires: aBoolean [
	drawWires := aBoolean.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCube >> initialize [

	super initialize.
	
	drawWires := true.
	self color: Color red.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:47'
}
SRCube >> isCube [
	^ true.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 9/18/2026 11:36'
}
SRCube >> renderOn: aSRRenderer [

	drawWires
		ifTrue: [aSRRenderer renderCubeTransformed: self globalTransform withColor: self color]
		ifFalse: [aSRRenderer renderPlainCubeTransformed: self globalTransform withColor: self color].
]
