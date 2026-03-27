Extension { #name : #Vector }

{ #category : #'*SqueakXR-helpers' }
Vector >> asRaylibObject [

	^ self asRlVector
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/4/2026 19:04'
}
Vector >> closeTo: anotherVector [

	self with: anotherVector do: [:a :b | (a closeTo: b) ifFalse: [^ false]].
	^ true
]

{ #category : #'*SqueakXR-helpers' }
Vector class >> componentSelectors [

	^ #()
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/26/2026 16:33'
}
Vector >> componentSelectors [

	^ #(x y o i)
]

{ #category : #'*SqueakXR-helpers' }
Vector >> doesNotUnderstand: aMessage [	
	
	(self class selectorOnlyContainsComponents: aMessage selector)
		ifFalse: [^ super doesNotUnderstand: aMessage].
	
	^ self swizzle: aMessage selector
]

{ #category : #'*SqueakXR-helpers' }
Vector class >> selectorOnlyContainsComponents: aSelector [

	^ aSelector allSatisfy: [:c | self componentSelectors includes: c asSymbol]
]

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'lege 3/26/2026 16:32'
}
Vector >> swizzle: aString [
	
	| vector |
	vector := (self class vectorClassForComponentNumber: aString size) new.
	aString selector withIndexDo: [:component :index | | value |
		value := ('oi' indexOf: component ifAbsent: [nil]) ifNotNil: [:v | v - 1].
		vector componentAt: index put: (value ifNil: [self perform: component asSymbol])].
	^ vector
]

{ #category : #'*SqueakXR-helpers' }
Vector class >> vectorClassForComponentNumber: aNumber [

	self assert: aNumber > 1.
	aNumber = 2 ifTrue: [^ Vector2].
	aNumber = 3 ifTrue: [^ Vector3].
	aNumber = 4 ifTrue: [^ Vector4].
	self error: 'numbers above 4 not yet handled'
]
