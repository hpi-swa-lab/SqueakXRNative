Class {
	#name : #SRMiniView,
	#superclass : #SRObject,
	#instVars : [
		'subtree',
		'scale'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/3/2026 16:21'
}
SRMiniView >> miniTransform [ 

	| xform |
	xform := self globalTransform * (Matrix4x4 withScale: self scale).
	self subtree ifNotNil: [:top | | invT invR invS |
		invT := Matrix4x4 withOffset: top globalTranslation negated.
		invR := top globalRotation inverse asMatrix4x4.
		invS := Matrix4x4 withScale: 1 / top globalScale length asVector3.
		xform := xform * invS * invR * invT
	].
	^xform
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:46'
}
SRMiniView >> renderObjects: rendering on: aRenderer [

	| object |
	aRenderer withTransform: self miniTransform do: [
		[rendering isEmpty] whileFalse: [
			object := rendering removeFirst.
			[object renderOn: aRenderer]
			on: Error do: ["Don't care about rendering errors here!"]
		]
	]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:49'
}
SRMiniView >> renderOn: aRenderer [

	| renderingObjects |
	renderingObjects := self subtree ifNil: [^self] ifNotNil: [:tree | 
		tree allDescendantsSelect: [:obj | obj isRendering]
	].
	self renderObjects: renderingObjects on: aRenderer.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:48'
}
SRMiniView >> scale [
	^ scale
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:48'
}
SRMiniView >> scale: anObject [
	scale := anObject asVector3
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:48'
}
SRMiniView >> subtree [
	^ subtree
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/3/2026 15:48'
}
SRMiniView >> subtree: anObject [
	subtree := anObject
]
