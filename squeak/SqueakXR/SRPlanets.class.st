Class {
	#name : #SRPlanets,
	#superclass : #SRObject,
	#instVars : [
		'count',
		'planets'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRPlanets >> initPlanets [

	self childrenCopy do: [:p | self removeChild: p].
	planets := OrderedCollection new.
	
	1 to: count do: [:idx | | planet |
		planet := SRObject new
			addChild: (SRSphere new
				setScale: (ThreadSafeRandom next * 30cm + 10cm) asVector3;
				translation: 0 @ (30cm * idx + 100cm) @ 0).
		self addChild: planet.
		planets add: planet]
]

{ #category : #'as yet unclassified' }
SRPlanets >> initialize [

	super initialize.

	count := 5.
	
	self initPlanets.
]

{ #category : #'as yet unclassified' }
SRPlanets >> step: deltaTime [

	planets withIndexDo: [:planet :index | | rand |
		rand := (index * 10000 * 12.9898 * 43758.5453123) sin fractionPart.
		planet rotation:
			((DateAndTime now asDuration asMilliSeconds * 0.01 * (planets size + 1 - index)) \\ 360 + (rand * 360))
			@ 0
			@ 0]
]
