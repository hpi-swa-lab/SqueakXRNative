Class {
	#name : #SRRay,
	#superclass : #Object,
	#instVars : [
		'origin',
		'forward'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRRay class >> origin: aVector3 forward: anotherVector3 [

	^ self new
		origin: aVector3;
		forward: anotherVector3
]

{ #category : #accessing }
SRRay >> forward [

	^ forward
]

{ #category : #accessing }
SRRay >> forward: aVector3 [

	"must be normalized"
	forward := aVector3
]

{ #category : #accessing }
SRRay >> origin [

	^ origin
]

{ #category : #accessing }
SRRay >> origin: aVector3 [

	origin := aVector3
]

{ #category : #geometry }
SRRay >> project: aNumber [

	^ self origin + (self forward * aNumber)
]
