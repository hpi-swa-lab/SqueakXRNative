Class {
	#name : #SRObject,
	#superclass : #Object,
	#instVars : [
		'children',
		'globalTransform',
		'transformDirty',
		'parent',
		'transform'
	],
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRObject class >> toolIcon [

	^ #srobject
]

{ #category : #hierarchy }
SRObject >> addChild: aSRObject [
	
	| childWorld |
	childWorld := aSRObject world.
	
	(self hasChild: aSRObject) ifTrue: [^ self].
	(self hasAncestor: aSRObject) ifTrue: [
		self error: 'Cannot add ancestor of SRObject as child'].
	
	aSRObject parent ifNotNil: [:parent |
		parent removeChild: aSRObject].
	
	self children add: aSRObject.
	aSRObject parent: self.
	childWorld = self world ifFalse: [
		aSRObject worldChanged: childWorld]
]

{ #category : #hierarchy }
SRObject >> addChildren: aCollection [

	aCollection do: [:obj | self addChild: obj]
]

{ #category : #hierarchy }
SRObject >> allDescendants [

	"TODO: define order"
	^ {self. self children collect: [:child | child allDescendants]} flatten
]

{ #category : #hierarchy }
SRObject >> allDo: aBlock [

	aBlock cull: self.
	self childrenDo: [:child | child allDo: aBlock].
]

{ #category : #events }
SRObject >> cacheInvalidated [

	self allDo: #onCacheInvalidated.
]

{ #category : #hierarchy }
SRObject >> childCount [

	^ self children size
]

{ #category : #accessing }
SRObject >> children [

	^ children copy
]

{ #category : #hierarchy }
SRObject >> childrenDo: aBlock [

	self children do: aBlock
]

{ #category : #transforms }
SRObject >> collisionGeometry [

	^ nil
]

{ #category : #transforms }
SRObject >> globalScale [

	^ self globalTransform scale
]

{ #category : #transforms }
SRObject >> globalTransform [

	self globalTransformNeedsUpdate ifTrue: [self updateGlobalTransform].
	^ globalTransform
]

{ #category : #transforms }
SRObject >> globalTransformNeedsUpdate [

	^ transformDirty
]

{ #category : #transforms }
SRObject >> globalTranslation [

	^ self globalTransform translation
]

{ #category : #hierarchy }
SRObject >> hasAncestor: aSRObject [

	self parent ifNil: [^ false].
	self parent = aSRObject ifTrue: [^ true].
	^ self parent hasAncestor: aSRObject
]

{ #category : #hierarchy }
SRObject >> hasChild: aSRObject [

	^ self children includes: aSRObject
]

{ #category : #hierarchy }
SRObject >> hasParent [

	^ parent notNil
]

{ #category : #initialization }
SRObject >> initialize [

	children := OrderedCollection new.
	transform := Matrix4x4 identity.
	transformDirty := true.
]

{ #category : #events }
SRObject >> keyboardEvent: aCharacter [
]

{ #category : #transforms }
SRObject >> localTransform [

	^ transform
]

{ #category : #transforms }
SRObject >> localTransform: aMatrix4x4 [

	self transform: aMatrix4x4
]

{ #category : #events }
SRObject >> onCacheInvalidated [
]

{ #category : #events }
SRObject >> onRaycast: aSRRayIntersectionResult [

	self changed: #raycast with: aSRRayIntersectionResult
]

{ #category : #events }
SRObject >> onWorldChanged: oldWorld [
]

{ #category : #events }
SRObject >> onWorldStarted [

]

{ #category : #accessing }
SRObject >> parent [

	^ parent
]

{ #category : #accessing }
SRObject >> parent: aSRObject [

	parent := aSRObject
]

{ #category : #hierarchy }
SRObject >> removeChild: aSRObject [

	self children remove: aSRObject ifAbsent: [^ self].
	aSRObject parent: nil.
]

{ #category : #rendering }
SRObject >> renderOn: aRenderer [

	"children should override this"
]

{ #category : #rendering }
SRObject >> renderSelfAndChildrenOn: aSRRenderer [

	self renderOn: aSRRenderer;
		childrenDo: [:child | child renderSelfAndChildrenOn: aSRRenderer]
]

{ #category : #transforms }
SRObject >> rotation: aVector3 [

	transform rotation: aVector3.
	self transformIsDirty.
]

{ #category : #transforms }
SRObject >> scale [

	^ self transform scale
]

{ #category : #transforms }
SRObject >> scaleBy: aVector3 [

	self transform: (self transform scaledBy: aVector3).
	self transformIsDirty.
]

{ #category : #transforms }
SRObject >> setRotationFromQuaternion: aQuaternion [

	transform setFromQuaternion: aQuaternion.
	self transformIsDirty.
]

{ #category : #transforms }
SRObject >> setScale: aVector3 [

	self transform setScale: aVector3.
	self transformIsDirty.
]

{ #category : #accessing }
SRObject >> step: deltaTime [
]

{ #category : #transforms }
SRObject >> transform [

	^ transform
]

{ #category : #transforms }
SRObject >> transform: aMatrix4x4 [

	transform := aMatrix4x4.
	self transformIsDirty.
]

{ #category : #transforms }
SRObject >> transformIsDirty [

	transformDirty := true
]

{ #category : #transforms }
SRObject >> translation [

	^ self transform translation
]

{ #category : #transforms }
SRObject >> translation: aVector3 [

	transform translation: aVector3.
	self transformIsDirty.
]

{ #category : #transforms }
SRObject >> updateGlobalTransform [

	globalTransform := self hasParent
		ifTrue: [self parent globalTransform * self transform]
		ifFalse: [self transform]
]

{ #category : #accessing }
SRObject >> world [

	self isWorldObject ifTrue: [^ self].
	self parent
		ifNil: [^ nil]
		ifNotNil: [^ self parent world]
]

{ #category : #events }
SRObject >> worldChanged: oldWorld [

	self cacheInvalidated.
	self allDo: [:object | object onWorldChanged: oldWorld].
]
