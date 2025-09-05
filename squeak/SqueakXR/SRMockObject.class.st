Class {
	#name : #SRMockObject,
	#superclass : #SRObject,
	#instVars : [
		'onWorldChangedCount',
		'previousWorld'
	],
	#category : #'SqueakXR-Tests-Objects'
}

{ #category : #'as yet unclassified' }
SRMockObject >> initialize [

	super initialize.

	onWorldChangedCount := 0.
	previousWorld := nil.
]

{ #category : #'as yet unclassified' }
SRMockObject >> onWorldChanged: oldWorld [

	onWorldChangedCount := onWorldChangedCount + 1.
	previousWorld := oldWorld.
]

{ #category : #'as yet unclassified' }
SRMockObject >> onWorldChangedCount [

	^ onWorldChangedCount
]

{ #category : #'as yet unclassified' }
SRMockObject >> previousWorld [

	^ previousWorld
]
