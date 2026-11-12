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
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:50'
}
SRRotationHandle class >> innerR [

	^ 1m
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:36'
}
SRRotationHandle class >> mesh [
	
	^ Mesh ifNil: [Mesh := SRMesh withSource: self meshSource]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:38'
}
SRRotationHandle class >> meshFilePath [
	
	^ (SRAssets assetsDirectory / 'models' / 'rotation_handle.obj') fullName 
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:36'
}
SRRotationHandle class >> meshSource [ 

	^ SRMeshSourceFile new
		path: self meshFilePath
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
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:49'
}
SRRotationHandle class >> width [
	
	^10cm
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/6/2026 16:20'
}
SRRotationHandle >> axis [
	
	^ self backward
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/12/2026 18:24'
}
SRRotationHandle >> collisionGeometry [ 

	| width |
	width := (localGrabPoint ifNotNil: [100] ifNil: [self class width]) * self globalScale x.
	^ SRCollisionRing new
		point: self globalTranslation;
		normal: self axis;
		innerR: self class innerR * self globalScale x;
		width: width;
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
	#'squeak_changestamp' : 'phkeese 11/12/2026 18:26'
}
SRRotationHandle >> dragTo: xform [


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

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/12/2026 18:36'
}
SRRotationHandle >> step: deltaTime [

	localGrabPoint ifNotNil: [:point | | end color x |
		end := self globalTransform localPointToGlobal: point.
		color := self color muchDarker.
		x := self grabbingHand cursorPoint.
		self gizmoPainter 
			gizmoPoint: end color: color;
			gizmoLine: self globalTranslation to: end color: color;
			gizmoLine: end to: x color: color.
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/12/2026 18:24'
}
SRRotationHandle >> wantsGrab [
	^true
]
