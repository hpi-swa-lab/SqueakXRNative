Class {
	#name : #SRMiniHalo,
	#superclass : #SRHalo,
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:30'
}
SRMiniHalo >> addHandles [ 
	
	| mini |
	mini := SRMiniHaloProxy new.
	self addChild: mini.
	mini globalTransform: self miniTransform * self target globalTransform.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 13:13'
}
SRMiniHalo >> initialize [

	super initialize.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:29'
}
SRMiniHalo >> miniTransform [
	^ self globalTransform * (Matrix4x4 withScale: 0.1 asVector3)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:43'
}
SRMiniHalo >> miniTransformToGlobal: mini [
	^ self miniTransform inverseTransformation * mini
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:29'
}
SRMiniHalo >> renderOn: aRenderer [
	"Render the entire world as a small model at my position."

	| xform |
	xform := self miniTransform.
	aRenderer
		withTransform: xform
		do: [ 
			[ 
			self world
				allDescendantsSelect: [ :obj | obj isRendering and: [ obj ~= self ] ]
				thenDo: [ :obj | obj renderOn: aRenderer ] ]
				on: Error
				do: [  ] ]
]
