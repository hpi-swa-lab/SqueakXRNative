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
