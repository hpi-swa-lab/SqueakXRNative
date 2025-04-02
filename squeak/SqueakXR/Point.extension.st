Extension { #name : #Point }

{ #category : #'*SqueakXR-helpers' }
Point >> asVector [

	^ Vector2 x: self x y: self y
]
