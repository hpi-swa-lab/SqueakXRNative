Extension { #name : #Object }

{ #category : #'*SqueakXR-helpers' }
Object >> asRaylibObject [

	self error: 'asRaylibObject is not implemented for ', self class name
]

{ #category : #'*SqueakXR-core' }
Object >> isWorldObject [

	^ false
]
