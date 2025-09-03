Class {
	#name : #SRCube,
	#superclass : #SRObject,
	#instVars : [
		'color'
	],
	#category : #'SqueakXR-Objects'
}

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

{ #category : #rendering }
SRCube >> renderOn: aSRRenderer [

	aSRRenderer renderCubeTransformed: self globalTransform withColor: self color.
]
