Class {
	#name : #SRCollisionGeometry,
	#superclass : #Object,
	#instVars : [
		'object'
	],
	#category : #'SqueakXR-Collisions'
}

{ #category : #'as yet unclassified' }
SRCollisionGeometry class >> toolIcon [

	^ #srcollision
]

{
	#category : #testing,
	#'squeak_changestamp' : 'phkeese 8/11/2026 10:57'
}
SRCollisionGeometry >> distanceTo: aPoint [
	^ Float infinity 
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:17'
}
SRCollisionGeometry >> ifCollisionGeometry: aBlock [

	^ aBlock value: self
]

{ #category : #collisions }
SRCollisionGeometry >> intersectsWithRay: aRay [

	^ (self rayIntersection: aRay) notNil
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:09'
}
SRCollisionGeometry >> isCollisionBox [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:13'
}
SRCollisionGeometry >> isCollisionNull [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:09'
}
SRCollisionGeometry >> isCollisionPlane [

	^ false
]

{ #category : #accessing }
SRCollisionGeometry >> object [

	^ object
]

{ #category : #accessing }
SRCollisionGeometry >> object: aSRObject [

	object := aSRObject
]

{ #category : #collisions }
SRCollisionGeometry >> rayIntersection: aRay [

	^ self subclassResponsibility
]
