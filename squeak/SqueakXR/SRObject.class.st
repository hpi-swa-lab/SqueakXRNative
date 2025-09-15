Class {
	#name : #SRObject,
	#superclass : #Object,
	#instVars : [
		'children',
		'localTransform',
		'globalTransform',
		'localTranslation',
		'localRotation',
		'localScale',
		'parent',
		'transformDirtyFlag'
	],
	#category : #'SqueakXR-Objects'
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

	^ children
]

{ #category : #accessing }
SRObject >> childrenCopy [

	^ children copy
]

{ #category : #hierarchy }
SRObject >> childrenDo: aBlock [

	self children do: aBlock
]

{ #category : #collisions }
SRObject >> collisionGeometry [

	^ nil
]

{ #category : #transforms }
SRObject >> ensureTransformClean [

	self haltOnce.
	self transformDirtyFlag ifNil: [^ self].
	"Instead of syncing all of the components/transforms at the same time,
	we could probably only sync the ones that are currently needed.
	Would need more complex dirty flag handling, though."
	self transformDirtyFlag caseOf: {
		[#parentTransform] -> [self updateTransformsFromParentTransform].
		[#localComponent] -> [self updateTransformsFromLocalComponent].
		[#localTransform] -> [self updateTransformsFromLocalTransform].
		[#globalTransform] -> [self updateTransformsFromGlobalTransform].
	}.
	self transformDirtyFlag: nil.
]

{ #category : #transforms }
SRObject >> globalScale [

	self ensureTransformClean.
	^ self globalTransform scale
]

{ #category : #transforms }
SRObject >> globalTransform [

	self ensureTransformClean.
	^ globalTransform
]

{ #category : #transforms }
SRObject >> globalTransform: aMatrix4x4 [

	self globalTransformDirty.
	globalTransform := aMatrix4x4.
]

{ #category : #'transforms - internal' }
SRObject >> globalTransformDirty [

	self transformDirtyFlag: #globalTransform.
	self notifyTransformChanged.
]

{ #category : #transforms }
SRObject >> globalTranslation [

	self ensureTransformClean.
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
	
	localTransform := Matrix4x4 identity.
	localTranslation := Vector3 zero.
	localRotation := Quaternion identity.
	localScale := Vector3 one.
	
	self transformDirtyFlag: #localTransform.
]

{ #category : #events }
SRObject >> keyboardEvent: aCharacter [
]

{ #category : #'transforms - internal' }
SRObject >> localComponentDirty [

	self transformDirtyFlag: #localComponent.
	self notifyTransformChanged.
]

{ #category : #transforms }
SRObject >> localPosition [

	^ self translation
]

{ #category : #transforms }
SRObject >> localPosition: aVector3 [

	self translation: aVector3
]

{ #category : #transforms }
SRObject >> localRotation [

	self ensureTransformClean.
	^ localRotation
]

{ #category : #transforms }
SRObject >> localRotation: aQuaternion [

	self localComponentDirty.
	localRotation := aQuaternion.
]

{ #category : #transforms }
SRObject >> localScale [

	self ensureTransformClean.
	^ localScale
]

{ #category : #transforms }
SRObject >> localScale: aVector3 [

	self localComponentDirty.
	localScale := aVector3.
]

{ #category : #transforms }
SRObject >> localTransform [

	self ensureTransformClean.
	^ localTransform
]

{ #category : #transforms }
SRObject >> localTransform: aMatrix4x4 [

	self localTransformDirty.
	localTransform := aMatrix4x4.
]

{ #category : #'transforms - internal' }
SRObject >> localTransformDirty [

	self transformDirtyFlag: #localTransform.
	self notifyTransformChanged.
]

{ #category : #transforms }
SRObject >> localTranslation [

	self ensureTransformClean.
	^ localTranslation
]

{ #category : #transforms }
SRObject >> localTranslation: aVector3 [

	self localComponentDirty.
	localTranslation := aVector3.
]

{ #category : #'transforms - internal' }
SRObject >> notifyTransformChanged [

	self childrenDo: [:object | object parentTransformDirty].
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

	self allDo: [:object | object parentTransformDirty].
	parent := aSRObject.
]

{ #category : #transforms }
SRObject >> parentGlobalTransform [

	^ self hasParent
		ifTrue: [self parent globalTransform]
		ifFalse: [Matrix4x4 identity]
]

{ #category : #'transforms - internal' }
SRObject >> parentTransformDirty [

	transformDirtyFlag = #parentTransform ifFalse: [self ensureTransformClean].
	self transformDirtyFlag: #parentTransform.
	self notifyTransformChanged.
]

{ #category : #transforms }
SRObject >> position [

	^ self translation
]

{ #category : #transforms }
SRObject >> position: aVector3 [

	self translation: aVector3
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
SRObject >> rotation [

	^ self localRotation
]

{ #category : #transforms }
SRObject >> rotation: aQuaternion [

	self localRotation: aQuaternion
]

{ #category : #transforms }
SRObject >> scale [

	^ self localScale
]

{ #category : #transforms }
SRObject >> scale: aVector3 [
	
	self localScale: aVector3
]

{ #category : #'transforms - internal' }
SRObject >> setLocalComponentsFrom: aMatrix4x4 [

	localTranslation := aMatrix4x4 translation.
	localRotation := aMatrix4x4 rotationQuaternion.
	localScale := aMatrix4x4 scale.
]

{ #category : #'transforms - internal' }
SRObject >> setLocalTransformFromComponents [

	localTransform := (Matrix4x4 withOffset: localTranslation)
		* (Matrix4x4 fromQuaternion: localRotation)
		* (Matrix4x4 withScale: localScale)
]

{ #category : #accessing }
SRObject >> step: deltaTime [
]

{ #category : #transforms }
SRObject >> transform [

	^ self localTransform
]

{ #category : #transforms }
SRObject >> transform: aMatrix4x4 [

	self localTransform: aMatrix4x4
]

{ #category : #'transforms - internal' }
SRObject >> transformDirtyFlag [

	^ transformDirtyFlag
]

{ #category : #'transforms - internal' }
SRObject >> transformDirtyFlag: flag [

	"self haltOnce."
	"one of #localComponent, #localTransform, #globalTransform, #parentTransform"
	flag ~= #localComponent ifTrue: [self haltOnce].
	"flag = #localComponent ifTrue: [self haltOnce]."
	(flag ~= #localComponent and: [transformDirtyFlag = #localComponent]) ifTrue: [self haltOnce].
	transformDirtyFlag := flag
]

{ #category : #transforms }
SRObject >> translation [

	^ self localTranslation
]

{ #category : #transforms }
SRObject >> translation: aVector3 [

	self localTranslation: aVector3
]

{ #category : #'transforms - internal' }
SRObject >> updateGlobalTransform [

	globalTransform := self parentGlobalTransform * localTransform
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromGlobalTransform [

	| transform |
	self haltOnce.
	transform := self parentGlobalTransform inverseTransformation * globalTransform.
	localTransform := transform.
	self setLocalComponentsFrom: transform
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromLocalComponent [

	self haltOnce.
	self setLocalTransformFromComponents;
		updateGlobalTransform
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromLocalTransform [

	self haltOnce.
	self setLocalComponentsFrom: localTransform;
		updateGlobalTransform.
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromParentTransform [

	self haltOnce.
	self updateGlobalTransform
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
