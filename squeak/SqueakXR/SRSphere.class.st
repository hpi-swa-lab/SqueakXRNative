Class {
	#name : #SRSphere,
	#superclass : #SRObject,
	#instVars : [
		'color'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #collisions,
	#'squeak_changestamp' : 'phkeese 8/20/2026 13:41'
}
SRSphere >> collisionGeometry [
	^ SRCollisionSphere new
		object: self;
		center: self globalTranslation;
		radius: self globalScale x / 2;
		yourself
]

{ #category : #accessing }
SRSphere >> color [

	^ color
]

{ #category : #accessing }
SRSphere >> color: aColor [

	color := aColor
]

{ #category : #initializing }
SRSphere >> initialize [

	super initialize.
	
	self color: Color red.
]

{ #category : #rendering }
SRSphere >> renderOn: aSRRenderer [

	aSRRenderer renderSphereTransformed: self globalTransform withColor: self color.
]
