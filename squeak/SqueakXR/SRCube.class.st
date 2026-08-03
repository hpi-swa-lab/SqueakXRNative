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
