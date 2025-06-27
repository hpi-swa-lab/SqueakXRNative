Extension { #name : #Color }

{ #category : #'*Raylib-Core' }
Color >> asRaylibObject [ 

	^ self asRlColor
]

{ #category : #'*Raylib-Core' }
Color >> asRlColor [

	"TODO more efficient conversion. Caching?"
	^ RlColor new
		r: (self red * 255) asInteger;
		g: (self green * 255) asInteger;
		b: (self blue * 255) asInteger;
		a: (self alpha * 255) asInteger
]
