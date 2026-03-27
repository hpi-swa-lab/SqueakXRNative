Extension { #name : #Vector3 }

{ #category : #'*SqueakXR-helpers' }
Vector3 >> asRlVector [

	^ RlVector3 new x: self x; y: self y; z: self z
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> backward [

	^ self x: 0 y: 0 z: -1
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/26/2026 16:33'
}
Vector3 class >> componentSelectors [

	^ #(x y z o i)
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> down [

	^ self x: 0 y: -1 z: 0
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> forward [

	^ self x: 0 y: 0 z: 1
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> fromRlVector3: aRlVector3 [

	^ self
		x: aRlVector3 x
		y: aRlVector3 y
		z: aRlVector3 z
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> left [

	^ self x: -1 y: 0 z: 0
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> one [

	^ 1 asVector3
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> random [

	^ self new
		x: ThreadSafeRandom next * 2 - 1
		y: ThreadSafeRandom next * 2 - 1
		z: ThreadSafeRandom next * 2 - 1
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> right [

	^ self x: 1 y: 0 z: 0
]

{ #category : #'*SqueakXR-helpers' }
Vector3 class >> up [

	^ self x: 0 y: 1 z: 0
]
