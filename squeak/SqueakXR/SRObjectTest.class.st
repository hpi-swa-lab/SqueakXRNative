Class {
	#name : #SRObjectTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Core-Tests'
}

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
SRObjectTest >> testChildrenDo [

	| count object |
	object := SRObject new.
	
	object addChildren: {SRObject new. SRObject new. SRObject new}.
	
	count := 0.
	object childrenDo: [:child | child notNil. count := count + 1].
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
SRObjectTest >> testGlobalTransformDependsOnParent [

	| child parent transform |
	parent := SRObject new.
	child := SRObject new.
	transform := Matrix4x4 withOffset: 1 @ 2 @ 3.
	
	parent transform: transform.
	parent addChild: child.
	
	self assert: child globalTransform = transform.
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
