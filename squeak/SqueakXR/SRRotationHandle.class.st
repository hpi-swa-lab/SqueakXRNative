Class {
	#name : #SRRotationHandle,
	#superclass : #SRObject,
	#instVars : [
		'meshObject',
		'rotateAction',
		'localGrabPoint'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:55'
}
SRRotationHandle class >> innerR [

	^ 90cm
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:53'
}
SRRotationHandle class >> mesh [

	^ Mesh ifNil: [
		Mesh := SRMesh withSource: (
			SRMeshSourceRaylibGen torusRadius: 0.1 size: 2 radSeg: 8 sides: 64
	)]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:47'
}
SRRotationHandle class >> radius [

	^1m
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:55'
}
SRRotationHandle class >> width [
	
	^20cm
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/5/2026 17:44'
}
SRRotationHandle >> axis [
	
	^ self forward
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 15:02'
}
SRRotationHandle >> collisionGeometry [ 

	^ SRCollisionRing new
		point: self globalTranslation;
		normal: self axis;
		innerR: self class innerR * self globalScale x;
		width: self class width * self globalScale x;
		object: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 13:59'
}
SRRotationHandle >> color [

	^ meshObject material colDiffuse
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 13:59'
}
SRRotationHandle >> color: aColor [

	^ meshObject material colDiffuse: aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:59'
}
SRRotationHandle >> initialize [ 

	super initialize.
	meshObject := SRMeshObject withMesh: self class mesh.
	meshObject scale: 1@1@0.
	self addChild: meshObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:03'
}
SRRotationHandle >> onGrabStarted: aHand [

	| point |
	point := aHand cursorPoint ifNil: [^self].
	localGrabPoint := self globalTransform globalPointToLocal: point.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:03'
}
SRRotationHandle >> onGrabStopped: aHand [

	localGrabPoint := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:00'
}
SRRotationHandle >> rotateAction [
	^ rotateAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/6/2026 14:01'
}
SRRotationHandle >> rotateAction: aBlock [

	"Called with self and the rotation amount while the user is using this handle."
	rotateAction := aBlock
]
