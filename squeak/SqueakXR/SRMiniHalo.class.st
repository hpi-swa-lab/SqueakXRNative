Class {
	#name : #SRMiniHalo,
	#superclass : #SRHalo,
	#instVars : [
		'proxy',
		'view'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/20/2026 16:54'
}
SRMiniHalo >> addHandles [ 
	
	proxy globalTransform: self miniTransform * self target globalTransform.
	view subtree: self world.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/20/2026 17:11'
}
SRMiniHalo >> initialize [

	super initialize.
	proxy := self addChild: SRMiniHaloProxy new.
	view := self addChild: (SRMiniView new
		scale: 0.1 asVector3)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/20/2026 16:54'
}
SRMiniHalo >> miniTransform [
	^ view globalTransform
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:43'
}
SRMiniHalo >> miniTransformToGlobal: mini [
	^ self miniTransform inverseTransformation * mini
]
