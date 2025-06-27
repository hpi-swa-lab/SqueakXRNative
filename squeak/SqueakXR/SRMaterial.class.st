Class {
	#name : #SRMaterial,
	#superclass : #Object,
	#instVars : [
		'internalMaterial'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRMaterial >> finalize [

	self unloadInternalMaterial
]

{ #category : #initializing }
SRMaterial >> initialize [ 

	super initialize.
	
	internalMaterial := Raylib loadMaterialDefault.
]

{ #category : #accessing }
SRMaterial >> internalMaterial [

	^ internalMaterial
]

{ #category : #'as yet unclassified' }
SRMaterial >> unloadInternalMaterial [

	self internalMaterial ifNotNil: [Raylib unloadMaterial: self internalMaterial]
]
