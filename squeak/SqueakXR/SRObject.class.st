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
		'badRender',
		'grabTarget',
		'visible'
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

{
	#category : #'shader sources',
	#'squeak_changestamp' : 'MCPServer 8/10/2026 18:23'
}
SRObject class >> waterShader [
	<shaderSource: #waterShader>

	^ {
		#uniforms -> #(time).
		#frag -> '
#version 450

layout(location = 0) in vec2 fragTexCoord;
layout(location = 1) in vec4 fragColor;

layout(binding = 0) uniform sampler2D texture0;
layout(location = 2) uniform vec4 colDiffuse;

layout(location = 0) out vec4 finalColor;

void main()
{
      vec4 texelColor = texture(texture0, fragTexCoord) * colDiffuse * fragColor;
      finalColor = texelColor;
}'
} as: Dictionary
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'leo 8/12/2026 14:50'
}
SRObject >> addChild: aSRObject [
	
	| childWorld world |
	self assert: aSRObject ~= self.
	
	childWorld := aSRObject world.
	
	(self hasChild: aSRObject) ifTrue: [^ self].
	(self hasAncestor: aSRObject) ifTrue: [
		self error: 'Cannot add ancestor of SRObject as child'].
	
	aSRObject parent ifNotNil: [:parent |
		parent privateRemoveChild: aSRObject].
	
	self children add: aSRObject.
	aSRObject parent: self.
	world := self world.
	childWorld = world ifFalse: [
		aSRObject worldChanged: childWorld].
	
	self changed: #childAdded with: self.
	world ifNotNil: [world notifyObjectAdded: aSRObject].
]

{ #category : #hierarchy }
SRObject >> addChildren: aCollection [

	aCollection do: [:obj | self addChild: obj]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/1/2026 16:35'
}
SRObject >> addCustomMenuItemsTo: aMenu [
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

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'lege 3/16/2026 16:04'
}
SRObject >> allDescendantsSelect: aSelectBlock thenDo: aDoBlock [

	(self allDescendantsSelect: aSelectBlock) do: aDoBlock
]

{ #category : #hierarchy }
SRObject >> allDo: aBlock [

	aBlock cull: self.
	self childrenDo: [:child | child allDo: aBlock].
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'lege 8/3/2026 15:48'
}
SRObject >> ancestorChain [

	| current |
	current := self.
	^ (Array streamContents: [:stream |
		[current notNil] whileTrue: [
			stream nextPut: current.
			current := current parent]])
]

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:04'
}
SRObject >> backward [

	^ (self globalTransform localDirToGlobal: Vector3 backward) normalize
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/6/2025 15:18'
}
SRObject >> badRender [

	^ badRender
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/6/2025 15:18'
}
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

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:45'
}
SRObject >> castRayBackward [

	^ self castRayDirection: self backward
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:44'
}
SRObject >> castRayDirection: aGlobalDirection [

	| ray |
	self world ifNil: [^ nil].
	ray := SRRay
		origin: self globalTranslation
		forward: aGlobalDirection.
	^ ray castNearest: self world
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:45'
}
SRObject >> castRayDown [

	^ self castRayDirection: self down
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:44'
}
SRObject >> castRayForward [

	^ self castRayDirection: self forward
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:45'
}
SRObject >> castRayLeft [

	^ self castRayDirection: self left
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:45'
}
SRObject >> castRayRight [

	^ self castRayDirection: self right
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 18:45'
}
SRObject >> castRayUp [

	^ self castRayDirection: self up
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

{
	#category : #collisions,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 17:25'
}
SRObject >> collisionGeometry [

	^ nil
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 17:25'
}
SRObject >> collisionGeometryDo: aBlock [

	^ self collisionGeometry ifNotNil: [:geom | aBlock value: geom]
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/6/2025 15:22'
}
SRObject >> continueRendering [

	self badRender: false
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 9/29/2025 18:17'
}
SRObject >> continueStepping [

	self badStep: false
]

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:03'
}
SRObject >> down [

	^ (self globalTransform localDirToGlobal: Vector3 down) normalize
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:49'
}
SRObject >> dragTo: aMatrix4x4 [

	self globalTransform: aMatrix4x4.
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

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:03'
}
SRObject >> forward [

	^ (self globalTransform localDirToGlobal: Vector3 forward) normalize
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:14'
}
SRObject >> gizmo [
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:49'
}
SRObject >> gizmoPainter [

	^ self world ifNotNil: [:world | world gizmoPainter]
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 14:32'
}
SRObject >> gizmoSphere: localPosition [

	self gizmoSphere: localPosition size: 20cm
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:15'
}
SRObject >> gizmoSphere: size color: color [

	self gizmoPainter ifNotNil: [:painter | painter gizmoSphere: size color: color]
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:45'
}
SRObject >> gizmoSphere: localPosition size: size [

	self gizmoSphere: localPosition size: size color: Color red
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:45'
}
SRObject >> gizmoSphere: localPosition size: size color: color [

	self gizmoPainter ifNotNil: [:painter |
		painter
			gizmoSphere: (self transform localPointToGlobal: localPosition)
			size: size
			color: color]
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:43'
}
SRObject >> gizmoSphereGlobal: globalPosition [

	self gizmoSphere: globalPosition size: 20cm
]

{
	#category : #gizmos,
	#'squeak_changestamp' : 'lege 11/11/2025 13:31'
}
SRObject >> gizmoSphereLocal: localPosition [

	self gizmoSphere: (self globalTransform localPointToGlobal: localPosition) size: 20cm
]

{ #category : #transforms }
SRObject >> globalRotation [

	self ensureTransformClean.
	^ self globalTransform rotationQuaternion
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:09'
}
SRObject >> globalRotation: aQuaternion [

	self globalTransform setFromQuaternion: aQuaternion.
	self globalTransformDirty.
]

{ #category : #transforms }
SRObject >> globalScale [

	self ensureTransformClean.
	^ self globalTransform scale
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:10'
}
SRObject >> globalScale: aVector3 [

	self globalTransform setScale: aVector3.
	self globalTransformDirty.
]

{ #category : #transforms }
SRObject >> globalTransform [

	self ensureTransformClean.
	^ globalTransform
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:10'
}
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

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:10'
}
SRObject >> globalTranslation: aVector3 [

	self globalTransform translation: aVector3.
	self globalTransformDirty.
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 6/8/2026 15:08'
}
SRObject >> grabTarget [

	^ grabTarget ifNil: [self]
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'lege 7/16/2026 17:12'
}
SRObject >> grabTarget: anObjectOrNil [
	
	grabTarget := anObjectOrNil
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

{
	#category : #initialization,
	#'squeak_changestamp' : 'lege 7/20/2026 17:03'
}
SRObject >> initialize [

	children := OrderedCollection new.
	
	isStepping := (self class selectorDefinedByBase: #step:) not.
	badStep := false.
	isRendering := (self class selectorDefinedByBase: #renderOn:) not.
	badRender := false.
	
	visible := true.
	
	localTransform := Matrix4x4 identity.
	localTranslation := Vector3 zero.
	localRotation := Quaternion identity.
	localScale := Vector3 one.
	
	self transformDirtyFlag: #localTransform.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:50'
}
SRObject >> isCube [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:50'
}
SRObject >> isDebugHUD [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:51'
}
SRObject >> isGizmoPainter [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:51'
}
SRObject >> isMenu [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 7/20/2026 18:51'
}
SRObject >> isMenuItem [

	^ false
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 3/16/2026 16:16'
}
SRObject >> isMorphPanel [

	^ false
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'lege 7/20/2026 17:04'
}
SRObject >> isRendering [

	^ isRendering and: visible and: [badRender not]
]

{ #category : #stepping }
SRObject >> isStepping [

	^ isStepping and: [badStep not]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'lege 3/25/2026 17:24'
}
SRObject >> isXR [

	^ self world ifNotNil: [:world | world isXR] ifNil: [false]
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 5/11/2026 17:40'
}
SRObject >> isXRInputEmulator [

	^ false
]

{ #category : #events }
SRObject >> keyboardEvent: aCharacter [
]

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:04'
}
SRObject >> left [

	^ (self globalTransform localDirToGlobal: Vector3 left) normalize
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

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:10'
}
SRObject >> localRotation: aQuaternion [

	localRotation := aQuaternion.
	self localComponentDirty.
]

{ #category : #transforms }
SRObject >> localScale [

	self ensureTransformClean.
	^ localScale
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:10'
}
SRObject >> localScale: aVector3 [

	localScale := aVector3.
	self localComponentDirty.
]

{ #category : #transforms }
SRObject >> localTransform [

	self ensureTransformClean.
	^ localTransform
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:11'
}
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

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 10/8/2025 17:11'
}
SRObject >> localTranslation: aVector3 [

	localTranslation := aVector3.
	self localComponentDirty.
]

{
	#category : #transforms,
	#'squeak_changestamp' : 'lege 7/2/2026 11:40'
}
SRObject >> lookAt: aGlobalVector3 [

	self globalTransform: (
		Matrix4x4
			objectLookAt: aGlobalVector3
			from: self globalTranslation
			up: Vector3 up)
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

{
	#category : #events,
	#'squeak_changestamp' : 'lege 8/7/2026 18:02'
}
SRObject >> onGrabStarted: aHand [
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 8/7/2026 18:01'
}
SRObject >> onGrabStopped: aHand [
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

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'lege 4/2/2026 16:37'
}
SRObject >> openInWorld [

	self currentXRWorld
		ifNil: [self error: 'world is missing']
		ifNotNil: [:world | world addChild: self]
]

{ #category : #accessing }
SRObject >> parent [

	^ parent
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/16/2026 10:07'
}
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

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:54'
}
SRObject >> privateRemoveChild: aSRObject [
	"Detach without the removal notifications: reparenting is not removal."

	self children remove: aSRObject ifAbsent: [^ self].
	aSRObject parent: nil
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayBackward [

	^ self rayForDirection: self backward
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayDown [

	^ self rayForDirection: self down
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'lege 7/3/2026 17:43'
}
SRObject >> rayForDirection: aNormalizedVector3 [

	^ SRRay
		origin: self globalTranslation
		forward: aNormalizedVector3
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayForward [

	^ self rayForDirection: self forward
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayLeft [

	^ self rayForDirection: self left
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayRight [

	^ self rayForDirection: self right
]

{
	#category : #raycast,
	#'squeak_changestamp' : 'MCPServer 7/3/2026 17:46'
}
SRObject >> rayUp [

	^ self rayForDirection: self up
]

{ #category : #hierarchy }
SRObject >> remove [

	self parent ifNotNil: [:parent | parent removeChild: self]
]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'jl 8/10/2026 17:48'
}
SRObject >> removeChild: aSRObject [
	| oldWorld |
	(self children includes: aSRObject) ifFalse: [^ self].
	oldWorld := self world.
	self privateRemoveChild: aSRObject.
	self removedChild: aSRObject.

	oldWorld ifNotNil: [aSRObject worldChanged: oldWorld].
	self changed: #childRemoved with: {aSRObject. self}.
	oldWorld ifNotNil: [:world | world notifyObjectRemoved: aSRObject oldParent: self].

]

{
	#category : #hierarchy,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 15:54'
}
SRObject >> removedChild: aSRObject [
	"Hook: aSRObject was detached from me. Morphic counterpart: Morph>>removedMorph:."
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

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:04'
}
SRObject >> right [

	^ (self globalTransform localDirToGlobal: Vector3 right) normalize
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

{
	#category : #events,
	#'squeak_changestamp' : 'lege 8/7/2026 18:02'
}
SRObject >> startGrabbing: aHand [

	self update: #grabStarted with: aHand.
	self onGrabStarted: aHand.
]

{ #category : #stepping }
SRObject >> step: deltaTime [
]

{
	#category : #events,
	#'squeak_changestamp' : 'lege 8/7/2026 18:02'
}
SRObject >> stopGrabbing: aHand [

	self update: #grabStopped with: aHand.
	self onGrabStopped: aHand.
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

{
	#category : #'transforms - internal',
	#'squeak_changestamp' : 'lege 10/8/2025 17:09'
}
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

{
	#category : #directions,
	#'squeak_changestamp' : 'lege 11/3/2025 18:03'
}
SRObject >> up [

	^ (self globalTransform localDirToGlobal: Vector3 up) normalize
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

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/20/2026 17:02'
}
SRObject >> visible [

	^ visible
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/20/2026 17:28'
}
SRObject >> visible: aBoolean [

	self flag: #todo. "setting visible to false only disables the rendering for the object itself, but not for its children. should disable the entire subtree"
	visible := aBoolean
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
