"
Shows where an avatar's head is, to everyone but that avatar.
"
Class {
	#name : #SRHeadMarker,
	#superclass : #SRObject,
	#instVars : [
		'color'
	],
	#category : #'SqueakXR-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:27'
}
SRHeadMarker >> color [

	^ color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:27'
}
SRHeadMarker >> color: aColor [

	color := aColor
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:27'
}
SRHeadMarker >> initialize [

	super initialize.
	color := Color red.
	self
		name: 'head marker';
		scale: 20cm asVector3;
		ignoreCollision: true.
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 19:27'
}
SRHeadMarker >> renderOn: aSRRenderer [

	self isDescendantOfCurrentlyRenderingAvatar ifFalse: [
		aSRRenderer renderCubeTransformed: self globalTransform withColor: color]
]
