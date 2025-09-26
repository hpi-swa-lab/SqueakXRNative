Class {
	#name : #SRObjectTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects'
}

{ #category : #support }
SRObjectTest >> assertMatrix: aMatrix4x4 equals: aMatrixCollection [
	
	self assert: aMatrix4x4 = (Matrix4x4 newFrom: aMatrixCollection)
]

{ #category : #'tests - children' }
SRObjectTest >> testAddChild [

	| child parent |
	parent := SRObject new.
	child := SRObject new.
	
	parent addChild: child.
	
	self assert: parent childCount = 1.
	self assert: (parent children includesAllOf: {child}).
	self assert: (parent hasChild: child).
	self assert: child hasParent.
	self assert: child parent = parent.
]

{ #category : #'tests - children' }
SRObjectTest >> testAddChildNoCycles [

	| object1 object2 object3 |
	object1 := SRObject new.
	object2 := SRObject new.
	object3 := SRObject new.
	
	object1 addChild: object2.
	object2 addChild: object3.
	
	self should: [object3 addChild: object1]
		raise: Error
]

{ #category : #'tests - children' }
SRObjectTest >> testAddChildren [

	| parent child1 child2 child3 |
	parent := SRObject new.
	child1 := SRObject new.
	child2 := SRObject new.
	child3 := SRObject new.
	
	parent addChildren: {child1. child2. child3}.
	
	self assert: parent childCount = 3.
	parent children do: [:child |
		parent hasChild: child.
		self assert: child parent = parent].
]

{ #category : #'tests - transforms' }
SRObjectTest >> testAddingAChildUpdatesItsGlobalTransform [

	| child parent |
	parent := SRObject new.
	child := SRObject new.
	
	child localTranslation: 1 @ 2 @ 3.
	
	self assert: child globalTranslation equals: 1 @ 2 @ 3.
	
	parent localTranslation: 4 @ 5 @ 6.
	parent addChild: child.
	
	self assert: child globalTranslation equals: 5 @ 7 @ 9.
]

{ #category : #'tests - children' }
SRObjectTest >> testAllDescendants [

	| o1 o2 o3 o4 o5 |
	o1 := SRObject new.
	o2 := SRObject new.
	o3 := SRObject new.
	o4 := SRObject new.
	o5 := SRObject new.
	
	o1 addChild: o2.
	o1 addChild: o3.
	o3 addChild: o4.
	o3 addChild: o5.
	
	self assert: (o1 allDescendants includesAllOf: {o1. o2. o3. o4. o5}).
	self assert: o1 allDescendants size = 5.
]

{ #category : #'tests - children' }
SRObjectTest >> testAllDescendantsSelect [

	| o1 o2 o3 o4 o5 chosenObjects result |
	o1 := SRObject new.
	o2 := SRObject new.
	o3 := SRObject new.
	o4 := SRObject new.
	o5 := SRObject new.
	
	chosenObjects := {o1. o3. o5}.
	
	o1 addChild: o2.
	o1 addChild: o3.
	o3 addChild: o4.
	o3 addChild: o5.
	
	result := o1 allDescendantsSelect: [:object | chosenObjects includes: object].
	self assert: (result includesAllOf: chosenObjects).
	self assert: 3 equals: result size.
]

{ #category : #'tests - children' }
SRObjectTest >> testAllDo [

	| count object |
	object := SRObject new.
	
	object addChildren: {SRObject new. SRObject new. SRObject new}.
	object children first addChild: SRObject new.
	
	count := 0.
	object allDo: [:obj | obj notNil. count := count + 1].
	self assert: count = 5.
]

{ #category : #'tests - children' }
SRObjectTest >> testChildrenDo [

	| count object |
	object := SRObject new.
	
	object addChildren: {SRObject new. SRObject new. SRObject new}.
	
	count := 0.
	object childrenDo: [:child | count := count + 1].
	self assert: count = 3.
]

{ #category : #'tests - children' }
SRObjectTest >> testDoubleAddChild [

	| child parent |
	parent := SRObject new.
	child := SRObject new.
	
	parent addChild: child.
	parent addChild: child.
	
	self assert: parent childCount = 1.
]

{ #category : #'tests - transforms' }
SRObjectTest >> testGlobalTransformAffectsLocalTransform [

	| object parent |
	parent := SRObject new.
	parent localTranslation: 1 @ 2 @ 3. 
	
	object := SRObject new.
	parent addChild: object.
	object globalTransform:
		(Matrix4x4 withOffset: 4 @ 6 @ 8).
	
	self assertMatrix: object localTransform equals: #(
		1  0  0 3
		0  1  0 4
		0  0  1 5
		0  0  0  1).
	self assert: object localTranslation equals: 3 @ 4 @ 5.
	self assert: object localScale equals: 1 @ 1 @ 1.
	self assert: object localRotation equals: Quaternion identity.
]

{ #category : #'tests - transforms' }
SRObjectTest >> testGlobalTransformChaining [

	| child parent |
	parent := SRObject new.
	child := SRObject new.
	
	parent localTranslation: 1 @ 2 @ 3.
	child localTranslation: 4 @ 5 @ 6.
	parent addChild: child.
	
	self assert: child globalTranslation equals: 5 @ 7 @ 9.
	
	parent localTranslation: 11 @ 12 @ 13.
	
	self assert: child globalTranslation equals: 15 @ 17 @ 19.
]

{ #category : #'tests - transforms' }
SRObjectTest >> testGlobalTransformDependsOnParent [

	| child parent transform |
	parent := SRObject new.
	child := SRObject new.
	transform := Matrix4x4 withOffset: 1 @ 2 @ 3.
	
	parent transform: transform.
	child transform: transform.
	parent addChild: child.
	
	self assert: child globalTransform = (transform * transform).
]

{ #category : #'tests - children' }
SRObjectTest >> testHasAncestor [

	| object1 object2 object3 |
	object1 := SRObject new.
	object2 := SRObject new.
	object3 := SRObject new.
	
	object1 addChild: object2.
	object2 addChild: object3.
	
	self assert: (object3 hasAncestor: object1).
	self deny: (object1 hasAncestor: object3).
]

{ #category : #'tests - children' }
SRObjectTest >> testHasChild [

	
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalComponentsAffectTransforms [

	| object |
	object := SRObject new.
	object localTranslation: 1 @ 2 @ 3.
	object localRotation: (Quaternion angle: 90 axis: 0 @ 0 @ 1).
	object localScale: (4 @ 5 @ 6).
	
	self assertMatrix: object transform equals: #(
		0 -5  0  1
		4  0  0  2
		0  0  6  3
		0  0  0  1).
	self assertMatrix: object globalTransform equals: #(
		0 -5  0  1
		4  0  0  2
		0  0  6  3
		0  0  0  1).
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalRotationAffectsTransforms [

	| object |
	object := SRObject new.
	object localRotation: (Quaternion angle: 90 axis: 0 @ 0 @ 1).
	
	self assertMatrix: object transform equals: #(
		0 -1  0  0
		1  0  0  0
		0  0  1  0
		0  0  0  1).
	self assertMatrix: object globalTransform equals: #(
		0 -1  0  0
		1  0  0  0
		0  0  1  0
		0  0  0  1).
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalScaleAffectsTransforms [

	| object |
	object := SRObject new.
	object localScale: (4 @ 5 @ 6).
	
	self assertMatrix: object transform equals: #(
		4 0 0 0
		0 5 0 0
		0 0 6 0
		0 0 0 1).
	self assertMatrix: object globalTransform equals: #(
		4 0 0 0
		0 5 0 0
		0 0 6 0
		0 0 0 1).
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalTransformAffectsGlobalTransform [

	| object rotation scale translation |
	object := SRObject new.
	translation := 1 @ 2 @ 3.
	rotation := Quaternion angle: 90 axis: 0 @ 0 @ 1.
	scale := 4 @ 5 @ 6.
	object localTransform:
		(Matrix4x4 withOffset: translation)
		* (Matrix4x4 fromQuaternion: rotation)
		* (Matrix4x4 withScale: scale).
	
	self assertMatrix: object globalTransform equals: #(
		0 -5  0  1
		4  0  0  2
		0  0  6  3
		0  0  0  1).
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalTransformAffectsLocalComponents [

	| object rotation scale translation |
	object := SRObject new.
	translation := 1 @ 2 @ 3.
	rotation := Quaternion angle: 90 axis: 0 @ 0 @ 1.
	scale := 4 @ 5 @ 6.
	object localTransform:
		(Matrix4x4 withOffset: translation)
		* (Matrix4x4 fromQuaternion: rotation)
		* (Matrix4x4 withScale: scale).
	
	self assert: object localTranslation = translation.
	self assert: object localRotation = rotation.
	self assert: object localScale = scale.
]

{ #category : #'tests - transforms' }
SRObjectTest >> testLocalTranslationAffectsTransforms [

	| object |
	object := SRObject new.
	object localTranslation: 1 @ 2 @ 3.
	
	self assertMatrix: object transform equals: #(
		1 0 0 1
		0 1 0 2
		0 0 1 3
		0 0 0 1).
	self assertMatrix: object globalTransform equals: #(
		1 0 0 1
		0 1 0 2
		0 0 1 3
		0 0 0 1)
]

{ #category : #'tests - children' }
SRObjectTest >> testMoveChild [
]

{ #category : #'tests - children' }
SRObjectTest >> testMoveChildBetweenParents [

	| child parent1 parent2 |
	parent1 := SRObject new.
	parent2 := SRObject new.
	child := SRObject new.
	
	parent1 addChild: child.
	parent2 addChild: child.
	
	self deny: (parent1 hasChild: child).
	self assert: (parent2 hasChild: child).
	self assert: child parent = parent2.
]

{ #category : #'tests - children' }
SRObjectTest >> testOnWorldChanged [

	| o1 o2 mock world1 world2 |
	world1 := SRWorld new.
	world2 := SRWorld new.
	o1 := SRObject new.
	o2 := SRObject new.
	mock := SRMockObject new.
	
	self assert: mock onWorldChangedCount = 0.
	
	world1 addChild: o1.
	o1 addChild: mock.
	
	self assert: mock onWorldChangedCount = 1.
	self assert: mock previousWorld isNil.
	
	world2 addChild: o2.
	o2 addChild: mock.
	
	self assert: mock onWorldChangedCount = 2.
	self assert: mock previousWorld = world1.
]

{ #category : #'tests - children' }
SRObjectTest >> testRemoveChild [

	| child parent |
	parent := SRObject new.
	child := SRObject new.
	
	parent addChild: child.
	parent removeChild: child.
	
	self assert: parent childCount = 0.
	self deny: (parent hasChild: child).
	self assert: child parent = nil.
]

{ #category : #'tests - children' }
SRObjectTest >> testRemoveNonChild [

	| child fakeParent trueParent |
	trueParent := SRObject new.
	fakeParent := SRObject new.
	child := SRObject new.
	
	trueParent addChild: child.
	fakeParent removeChild: child.
	
	self assert: fakeParent childCount = 0.
	self assert: trueParent childCount = 1.
	self assert: child parent = trueParent.
]

{ #category : #'tests - children' }
SRObjectTest >> testWorld [

	| o1 o2 o3 world |
	world := SRWorld new.
	o1 := SRObject new.
	o2 := SRObject new.
	o3 := SRObject new.
	
	world addChild: o1.
	o1 addChild: o2.
	o2 addChild: o3.
	
	self assert: o3 world = world
]
