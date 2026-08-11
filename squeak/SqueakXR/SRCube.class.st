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
	#'squeak_changestamp' : 'MCPServer 7/30/2026 17:21'
}
SRCube class >> xrMenuSpawn: aMenu [
	<xrMenu: #(world) label: 'Spawn Cube' priority: 110>
	| cube |
	cube := self new
		position: aMenu position;
		scale: 30cm asVector3;
		yourself.
	aMenu world addChild: cube.
	^ cube
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/11/2026 16:18'
}
SRCube >> collisionGeometry [
	^ SRCollisionBox new
		center: self globalTranslation;
		size: self globalScale;
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
