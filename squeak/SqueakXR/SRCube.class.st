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
	#'squeak_changestamp' : 'MCPServer 7/30/2026 15:49'
}
SRCube class >> srMenuSpawn: aContext [
	<srMenu: #(world) label: 'Spawn Cube' priority: 110>
	| cube |
	cube := self new
		position: (aContext at: #position);
		scale: 30cm asVector3;
		yourself.
	(aContext at: #world) addChild: cube.
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
