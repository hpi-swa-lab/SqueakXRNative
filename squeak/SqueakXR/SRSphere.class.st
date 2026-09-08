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
	#'squeak_changestamp' : 'phkeese 9/8/2026 15:28'
}
SRSphere >> collisionGeometry [
	^ SRCollisionSphere new
		object: self;
		center: self globalTranslation;
		radius: self globalScale x;
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

{
	#category : #rendering,
	#'squeak_changestamp' : 'phkeese 9/8/2026 10:46'
}
SRSphere >> renderOn: aSRRenderer [

	aSRRenderer renderSphereTransformed: self globalTransform withColor: self color.
]
