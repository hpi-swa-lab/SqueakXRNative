Extension { #name : #Vector2 }

{ #category : #'*SqueakXR-helpers' }
Vector2 >> asRlVector [

	^ RlVector2 new
		x: self x;
		y: self y
]

{ #category : #'*SqueakXR-helpers' }
Vector2 class >> componentSelectors [

	^ #(x y)
]
