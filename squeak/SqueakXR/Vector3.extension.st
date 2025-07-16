Extension { #name : #Vector3 }

{ #category : #'*SqueakXR-helpers' }
Vector3 >> asRlVector [

	^ RlVector3 new x: self x; y: self y; z: self z
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> componentSelectors [

	^ #(x y z)
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> one [

	^ 1 asVector3
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> up [

	^ self x: 0 y: 1 z: 0
]
