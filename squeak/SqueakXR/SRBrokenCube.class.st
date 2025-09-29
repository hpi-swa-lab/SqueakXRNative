Class {
	#name : #SRBrokenCube,
	#superclass : #SRObject,
	#instVars : [
		'cube',
		'angle'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRBrokenCube >> initialize [

	super initialize.
	
	angle := 0.
	cube := SRCube new.
	self addChild: cube.
]

{ #category : #'as yet unclassified' }
SRBrokenCube >> step: delta [

	angle := 0.1 * delta + angle.
	self localAxis: Vector3 up angle: angle.
	ThreadSafeRandom next < 0.001 ifTrue: [self error: 'Whoops!'].
]
