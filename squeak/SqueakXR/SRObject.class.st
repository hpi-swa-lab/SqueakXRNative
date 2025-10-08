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
		'transformDirtyFlag',
		'name',
		'isStepping',
		'isRendering',
		'badStep',
		'badRender'
	],
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRObject class >> selectorDefinedByBase: aSymbol [

	^ (self lookupSelector: aSymbol) methodClass = SRObject
]

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
SRObject >> allDescendantsSelect: aBlock [

	| descendants |
	descendants := OrderedCollection new.
	self allDo: [:object |
		(aBlock value: object) ifTrue: [descendants add: object]].
	^ descendants
]

{ #category : #hierarchy }
SRObject >> allDo: aBlock [

	aBlock cull: self.
	self childrenDo: [:child | child allDo: aBlock].
]

{ #category : #accessing }
SRObject >> badRender [

	^ badRender
]

{ #category : #accessing }
SRObject >> badRender: aBoolean [

	badRender := aBoolean
]

{ #category : #accessing }
SRObject >> badStep [

	^ badStep
]

{ #category : #accessing }
SRObject >> badStep: aBoolean [

	badStep := aBoolean
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

{ #category : #accessing }
SRObject >> continueRendering [

	self badRender: false
]

{ #category : #accessing }
SRObject >> continueStepping [

	self badStep: false
]

{ #category : #transforms }
SRObject >> ensureTransformClean [

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
SRObject >> globalRotation [

	self ensureTransformClean.
	^ self globalTransform rotationQuaternion
]

{ #category : #transforms }
SRObject >> globalRotation: aQuaternion [

	self globalTransform setFromQuaternion: aQuaternion.
	self globalTransformDirty.
]

{ #category : #transforms }
SRObject >> globalScale [

	self ensureTransformClean.
	^ self globalTransform scale
]

{ #category : #transforms }
SRObject >> globalScale: aVector3 [

	self globalTransform setScale: aVector3.
	self globalTransformDirty.
]

{ #category : #transforms }
SRObject >> globalTransform [

	self ensureTransformClean.
	^ globalTransform
]

{ #category : #transforms }
SRObject >> globalTransform: aMatrix4x4 [

	globalTransform := aMatrix4x4.
	self globalTransformDirty.
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

{ #category : #transforms }
SRObject >> globalTranslation: aVector3 [

	self globalTransform translation: aVector3.
	self globalTransformDirty.
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
	
	isStepping := (self class selectorDefinedByBase: #step:) not.
	badStep := false.
	isRendering := (self class selectorDefinedByBase: #renderOn:) not.
	badRender := false.
	
	localTransform := Matrix4x4 identity.
	localTranslation := Vector3 zero.
	localRotation := Quaternion identity.
	localScale := Vector3 one.
	
	self transformDirtyFlag: #localTransform.
]

{ #category : #rendering }
SRObject >> isRendering [

	^ isRendering and: [badRender not]
]

{ #category : #stepping }
SRObject >> isStepping [

	^ isStepping and: [badStep not]
]

{ #category : #events }
SRObject >> keyboardEvent: aCharacter [
]

{ #category : #transforms }
SRObject >> localAxis: aVector3 angle: aNumber [

	self localRotation: (Quaternion angle: aNumber axis: aVector3)
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

	localRotation := aQuaternion.
	self localComponentDirty.
]

{ #category : #transforms }
SRObject >> localScale [

	self ensureTransformClean.
	^ localScale
]

{ #category : #transforms }
SRObject >> localScale: aVector3 [

	localScale := aVector3.
	self localComponentDirty.
]

{ #category : #transforms }
SRObject >> localTransform [

	self ensureTransformClean.
	^ localTransform
]

{ #category : #transforms }
SRObject >> localTransform: aMatrix4x4 [

	localTransform := aMatrix4x4.
	self localTransformDirty.
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

	localTranslation := aVector3.
	self localComponentDirty.
]

{ #category : #accessing }
SRObject >> name [

	^ name ifNil: [self class asString]
]

{ #category : #accessing }
SRObject >> name: aString [

	name := aString
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
SRObject >> remove [

	self parent ifNotNil: [:parent | parent removeChild: self]
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

{ #category : #stepping }
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
	transform := self parentGlobalTransform inverseTransformation * globalTransform.
	localTransform := transform.
	self setLocalComponentsFrom: transform
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromLocalComponent [

	self setLocalTransformFromComponents;
		updateGlobalTransform
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromLocalTransform [

	self setLocalComponentsFrom: localTransform;
		updateGlobalTransform.
]

{ #category : #'transforms - internal' }
SRObject >> updateTransformsFromParentTransform [

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
