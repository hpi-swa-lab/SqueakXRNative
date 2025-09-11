Class {
	#name : #SRTree,
	#superclass : #SRObject,
	#category : #'SqueakXR-Objects'
}

{ #category : #'as yet unclassified' }
SRTree class >> branchDistance [

	^ 100cm
]

{ #category : #'as yet unclassified' }
SRTree >> addNode: subnodeCount [

	| dir color |
	dir := Vector3 random normalize * self class branchDistance.
	dir := dir * (dir collect: [:x | x sign]).
	color := subnodeCount caseOf: {
	[3] -> [Color blue].
	[2] -> [Color yellow].
	[1] -> [Color green].} otherwise: [Color blue].
	self addChild: (SRTree new
			addNodes: subnodeCount;
			translation: dir;
			color: color).
]

{ #category : #'as yet unclassified' }
SRTree >> addNodes: count [

	count = 0 ifTrue: [^self].
	1 to: (count * (ThreadSafeRandom nextInt: 5)) do: [:idx | self addNode: count - 1]
]

{ #category : #'as yet unclassified' }
SRTree >> color: color [

	self children first color: color
]

{ #category : #'as yet unclassified' }
SRTree >> initialize [

	super initialize.
	
	self addChild: (SRSphere new setScale: 10cm asVector3).
]

{ #category : #'as yet unclassified' }
SRTree >> renderOn: aRenderer [

	super renderOn: aRenderer.
	self children do: [:child |
		child class = SRSphere ifFalse: [
			Raylib drawLine3DStartPos: self globalTranslation asRlVector endPos: child globalTranslation asRlVector color: Color black asRlColor]]
]
