Class {
	#name : #SRAvatar,
	#superclass : #SRObject,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRAvatar >> initialize [

	super initialize.

	self addChild: SRHand left;
		addChild: SRHand right.
]
