Class {
	#name : #SRSphere,
	#superclass : #SRObject,
	#instVars : [
		'color'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #rendering }
SRSphere >> collisionGeometry [

	^ SRCollisionSphere new
		center: self globalTranslation;
		radius: self globalScale x;
		object: self
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
