Class {
	#name : #SRRingHalo,
	#superclass : #SRHalo,
	#instVars : [
		'label',
		'targetLocalTransform',
		'mini'
	],
	#category : #'SqueakXR-Halo'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 11/6/2026 16:20'
}
SRRingHalo >> addButtons: aList [

	"Add buttons in a ring-like fashoin around my center."
	| step position xform |
	step := 360 / aList size.
	xform := Quaternion angle: step axis: Vector3 backward.
	position := Vector3 up * 0.3.
	aList do: [:btn |
		btn position: position.
		self addChild: btn.
		position := xform rotateVector: position.
	]

	
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:45'
}
SRRingHalo >> addHandles [ 

	| buttons |
	buttons := OrderedCollection new.
	buttons add: (SRHaloButton new
		text: 'Inspect';
		clickAction: [ self target inspect. self close ];
		color: Color gray);
		add: (SRHaloButton new
		text: 'Remove';
		clickAction: [ self target remove. self close ];
		color: Color red).
	3 timesRepeat: [ buttons add: (SRHaloButton new
		text: '<Dummy>') ].
	self addButtons: buttons.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:49'
}
SRRingHalo >> collisionGeometry [ 

	"Answer a single box in my center."
	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale / 20;
		rotation: self globalRotation;
		object: self
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (leo) 11/9/2026 13:33'
}
SRRingHalo >> initialize [ 

	super initialize.
	
	label := SRTextField new
		scale: 0.1 asVector3;
		position: (0@ -0.2@0);
		rotation: SRTextField uprightRotation;
		yourself.
	self addChild: label.
	mini := SRMiniView new
		scale: 0.1 asVector3.
	self addChild: mini.
	
	self frozen: true.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:53'
}
SRRingHalo >> startGrabbing: aHand [

	targetLocalTransform := (self globalTransform inverseTransformation * self target globalTransform)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/29/2026 16:14'
}
SRRingHalo >> step: deltaTime [ 

	super step: deltaTime.
	targetLocalTransform ifNotNil: [:xform | self target dragTo: self globalTransform * xform ]
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 10/13/2026 09:53'
}
SRRingHalo >> stopGrabbing: aHand [

	targetLocalTransform := nil
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 11/3/2026 16:44'
}
SRRingHalo >> target: anObject [

	label text: '', anObject.
	mini subtree: anObject.
	^ super target: anObject
]
