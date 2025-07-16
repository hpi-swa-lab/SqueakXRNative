Extension { #name : #Number }

{ #category : #'*SqueakXR-helpers' }
Number >> asVector3 [

	^ Vector3 value: self
]

{ #category : #'*SqueakXR-helpers' }
Number >> cm [

	^ self * 0.01
]

{ #category : #'*SqueakXR-helpers' }
Number >> dm [

	^ self * 0.1
]

{ #category : #'*SqueakXR-helpers' }
Number >> km [

	^ self * 1000
]

{ #category : #'*SqueakXR-helpers' }
Number >> m [

	^ self
]

{ #category : #'*SqueakXR-helpers' }
Number >> mm [

	^ self * 0.001
]
