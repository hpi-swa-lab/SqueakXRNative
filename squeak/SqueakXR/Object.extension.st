Extension { #name : #Object }

{ #category : #'*SqueakXR-helpers' }
Object >> asRaylibObject [

	self error: 'asRaylibObject is not implemented for ', self class name
]

{
	#category : #'*SqueakXR-core',
	#'squeak_changestamp' : 'lege 4/2/2026 16:41'
}
Object >> currentXRWorld [

	^ SRWorld current
]

{ #category : #'*SqueakXR-core' }
Object >> isWorldObject [

	^ false
]
