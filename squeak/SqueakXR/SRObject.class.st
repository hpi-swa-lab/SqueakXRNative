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

{ #category : #children }
SRObject >> addChild: aSRObject [

	"DISCUSS: Adding an object to a different world means that the world cache is no longer valid for the child,
	and thus onCacheInvalidated and onWorldStarted must be called for it.
	This could be done here with a simple check.
	However, this also seems like a very unlikely use case, so I'm not going to do it for now."
	
	(self hasChild: aSRObject) ifTrue: [^ self].
	(self hasAncestor: aSRObject) ifTrue: [
		self error: 'Cannot add ancestor of SRObject as child'].
	
	aSRObject parent ifNotNil: [:parent |
		parent removeChild: aSRObject].
	
	self children add: aSRObject.
	aSRObject parent: self.
]

{ #category : #children }
SRObject >> addChildren: aCollection [

	aCollection do: [:obj | self addChild: obj]
]

{ #category : #children }
SRObject >> allDescendants [

	"TODO: define order"
	^ {self. self children collect: [:child | child allDescendants]} flatten
]

{ #category : #children }
SRObject >> allDo: aBlock [

	aBlock cull: self.
	self childrenDo: aBlock.
]

{ #category : #'as yet unclassified' }
SRObject >> cacheInvalidated [

	self allDo: #onCacheInvalidated.
]

{ #category : #children }
SRObject >> childCount [

	^ self children size
]

{ #category : #accessing }
SRObject >> children [

	^ children
]

{ #category : #children }
SRObject >> childrenDo: aBlock [

	self children do: aBlock
]

{ #category : #accessing }
SRObject >> globalTransform [

	self globalTransformNeedsUpdate ifTrue: [self updateGlobalTransform].
	^ globalTransform
]

{ #category : #transforms }
SRObject >> globalTransformNeedsUpdate [

	^ transformDirty
]

{ #category : #children }
SRObject >> hasAncestor: aSRObject [

	self parent ifNil: [^ false].
	self parent = aSRObject ifTrue: [^ true].
	^ self parent hasAncestor: aSRObject
]

{ #category : #children }
SRObject >> hasChild: aSRObject [

	^ self children includes: aSRObject
]

{ #category : #children }
SRObject >> hasParent [

	^ parent notNil
]

{ #category : #initialization }
SRObject >> initialize [

	children := OrderedCollection new.
	transform := Matrix4x4 identity.
	transformDirty := true.
]

{ #category : #accessing }
SRObject >> localTransform [

	^ transform
]

{ #category : #accessing }
SRObject >> localTransform: aMatrix4x4 [

	self transform: aMatrix4x4
]

{ #category : #lifecycle }
SRObject >> onCacheInvalidated [
]

{ #category : #lifecycle }
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

{ #category : #children }
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

{ #category : #accessing }
SRObject >> step: deltaTime [
]

{ #category : #accessing }
SRObject >> transform [

	^ transform
]

{ #category : #accessing }
SRObject >> transform: aMatrix4x4 [

	transform := aMatrix4x4.
	transformDirty := true.
]

{ #category : #transforms }
SRObject >> updateGlobalTransform [

	globalTransform := self hasParent
		ifTrue: [self transform * self parent globalTransform]
		ifFalse: [self transform]
]

{ #category : #accessing }
SRObject >> world [

	self isWorldObject ifTrue: [^ self].
	self parent
		ifNil: [^ nil]
		ifNotNil: [^ self parent world]
]
