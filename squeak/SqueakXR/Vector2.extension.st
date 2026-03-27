Extension { #name : #Vector2 }

{ #category : #'*SqueakXR-helpers' }
Vector2 >> asRlVector [

	^ RlVector2 new
		x: self x;
		y: self y
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/26/2026 16:33'
}
Vector2 class >> componentSelectors [

	^ #(x y o i)
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 10/13/2025 18:05'
}
Vector2 >> distanceTo: aVector [
	^(self - aVector) length
]
