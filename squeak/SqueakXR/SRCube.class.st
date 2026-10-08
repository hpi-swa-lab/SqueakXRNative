Class {
	#name : #SRCube,
	#superclass : #SRObject,
	#instVars : [
		'color'
	],
	#category : #'SqueakXR-Objects'
}

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

{ #category : #initializing }
SRCube >> initialize [

	super initialize.
	
	self color: Color red.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:47'
}
SRCube >> isCube [
	^ true.
]

{ #category : #rendering }
SRCube >> renderOn: aSRRenderer [

	aSRRenderer renderCubeTransformed: self globalTransform withColor: self color.
]
