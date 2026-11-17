Class {
	#name : #SRRotationHandle,
	#superclass : #SRObject,
	#instVars : [
		'meshObject',
		'grabAction',
		'rotateAction',
		'startPoint',
		'lastPoint',
		'grabberLocalPoint',
		'angle'
	],
	#classVars : [
		'Mesh'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/16/2026 13:35'
}
SRRotationHandle class >> grabbedInnerR [ 
	^self innerR - (self grabbedWidth / 2)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/16/2026 15:37'
}
SRRotationHandle class >> grabbedWidth [
	^ self innerR 
]

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
	#'squeak_changestamp' : 'phkeese 11/12/2026 17:49'
}
SRRotationHandle class >> width [
	
	^10cm
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 14:11'
}
SRRotationHandle >> angle [

	^angle 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:15'
}
SRRotationHandle >> axis [
	
	^ self forward
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:32'
}
SRRotationHandle >> axis: aVector [
	
	self lookAt: self globalTranslation + aVector
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 13:34'
}
SRRotationHandle >> collisionGeometry [ 

	| width innerR |
	width := self isGrabbed ifTrue: [ self class grabbedWidth ] ifFalse: [ self class width ].
	innerR := self isGrabbed ifTrue: [ self class grabbedInnerR ] ifFalse: [ self class innerR ].
	^SRCollisionRing new
		innerR: innerR * self globalScale x;
		width: width * self globalScale x;
		point: self globalTranslation;
		normal: self axis;
		object: self;
		yourself
		
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 13:26'
}
SRRotationHandle >> color [

	^ meshObject material colDiffuse ifNil: [ Color white ]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/13/2026 13:54'
}
SRRotationHandle >> color: aColor [

	meshObject material colDiffuse: aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 13:21'
}
SRRotationHandle >> dragTo: xform [

	"Left blank to avoid following the hand around"
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:19'
}
SRRotationHandle >> grabAction [
	^ grabAction
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 16:20'
}
SRRotationHandle >> grabAction: aBlock [

	"Set an action to perform when I am grabbed, passing myself as its argument."
	grabAction := aBlock
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 14:11'
}
SRRotationHandle >> initialize [ 

	super initialize.
	angle := 0.
	meshObject := SRMeshObject withMesh: self class mesh.
	meshObject scale: 1@1@0.
	self addChild: meshObject.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/13/2026 13:56'
}
SRRotationHandle >> isGrabbed [
	^ self grabbingHand notNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/17/2026 13:28'
}
SRRotationHandle >> onGrabStarted: aHand [

	| point |
	point := aHand cursorPoint ifNil: [^self].
	startPoint := self globalTransform globalPointToLocal: point.
	grabberLocalPoint := aHand cursor grabbingTransform globalPointToLocal: point.
	self grabAction ifNotNil: [:action |
		action cull: self
	]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/16/2026 13:23'
}
SRRotationHandle >> onGrabStopped: aHand [

	startPoint := nil.
	lastPoint := nil.
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
	#'squeak_changestamp' : 'phkeese 11/16/2026 14:10'
}
SRRotationHandle >> step: deltaTime [
	
	self isGrabbed ifTrue: [ 
		self updateAngle.
		self rotateAction ifNotNil: [:action |
			action cull: self cull: angle
		]
	].
	
	startPoint ifNotNil: [ | toGlobal |
		toGlobal := self globalTransform.
		self gizmoPainter 
			gizmoLine: self globalTranslation to: (toGlobal localPointToGlobal: startPoint) color: self color;
			gizmoLine: self globalTranslation to: (toGlobal localPointToGlobal: lastPoint)  color: self color.
		]
	

]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/17/2026 13:46'
}
SRRotationHandle >> updateAngle [ 

	| grabPoint  |
	grabPoint := self grabbingHand cursor grabbingTransform localPointToGlobal: grabberLocalPoint.
	self gizmoPainter gizmoPoint: grabPoint color: self color.
	lastPoint := self globalTransform globalPointToLocal: (grabPoint onPlanePoint: self globalTranslation normal: self axis).
	angle := startPoint angleTo: lastPoint axis: Vector3 forward.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'phkeese 11/12/2026 18:24'
}
SRRotationHandle >> wantsGrab [
	^true
]
