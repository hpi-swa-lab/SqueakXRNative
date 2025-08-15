Class {
	#name : #SRMorphProjection,
	#superclass : #SRObject,
	#instVars : [
		'morph',
		'plane',
		'texture'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRMorphProjection class >> defaultPixelsPerMeter [

	^ 100
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> initialize [

	super initialize.
	
	plane := SRPlane new.
	texture := SRMorphTexture new.
	self addChild: plane.
]

{ #category : #accessing }
SRMorphProjection >> morph [

	^ morph
]

{ #category : #accessing }
SRMorphProjection >> morph: aMorph [

	morph := aMorph.
	
	texture morph: morph.
	self updateTexture.
]

{ #category : #'as yet unclassified' }
SRMorphProjection >> setSizeFromPixelsPerMeter: aNumber [

	plane setScale: (self morph width / aNumber) @ 1 @ (self morph height / aNumber)
]

{ #category : #accessing }
SRMorphProjection >> updateTexture [

	self setSizeFromPixelsPerMeter: self class defaultPixelsPerMeter.
	plane material texture: texture update.
	
]
