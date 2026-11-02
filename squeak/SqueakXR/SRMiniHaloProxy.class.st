"
A SRMiniHaloProxy is a small, grabbable object which represents a the halo target in a mini world.
It uses its halo's transform to apply translation and rotation during grabbing to the target object.

Instance Variables
	halo:		<Object>

halo
	- xxxxx

"
Class {
	#name : #SRMiniHaloProxy,
	#superclass : #SRObject,
	#instVars : [
		'dragging',
		'label'
	],
	#category : #'SqueakXR-Halo',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:16'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:48'
}
SRMiniHaloProxy >> collisionGeometry [ 

	^SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale / 2 * 1.1;
		rotation: self globalRotation;
		object: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:44'
}
SRMiniHaloProxy >> dragTo: xform [

	super dragTo: xform.
	self target globalTransform: (self parent miniTransformToGlobal: self globalTransform).
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 15:29'
}
SRMiniHaloProxy >> initialize [ 

	super initialize.
	dragging := false.
	label := SRTextField new
		position: Vector3 up;
		scale: 0.3 asVector3;
		text: 'Label';
		centered: true.
	self addChild: label.
	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:50'
}
SRMiniHaloProxy >> renderOn: aRenderer [

	| box |
	box := self globalTransform * (Matrix4x4 withScale: 1.1 asVector3).
	aRenderer renderWireCubeTransformed: box withColor: Color gray.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:46'
}
SRMiniHaloProxy >> startDragging: aHand [

	dragging := true
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 15:43'
}
SRMiniHaloProxy >> step: deltaTime [

	| xform labelPos end |
	dragging ifFalse: [
		self globalTransform: self parent miniTransform * self target globalTransform
	].
	labelPos := self globalTranslation  + (0@10cm@0).
	xform := 
		(Matrix4x4 withOffset: labelPos)
		* (Matrix4x4 withScale: 3cm asVector3).
	label globalTransform: xform.
	label lookAtCamera.
	label text: self target name asString.
	end := self parent miniTransform localPointToGlobal: self target globalTranslation.
	self gizmoPainter gizmoLine: labelPos to: end color: Color gray.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:46'
}
SRMiniHaloProxy >> stopDragging: aHand [

	dragging := false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:36'
}
SRMiniHaloProxy >> target [
	^ self parent target
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/2/2026 14:34'
}
SRMiniHaloProxy >> wantsGrab [ 

	^true
]
