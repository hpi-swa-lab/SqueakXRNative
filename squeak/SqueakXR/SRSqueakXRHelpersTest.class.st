Class {
	#name : #SRSqueakXRHelpersTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Core'
}

{ #category : #'as yet unclassified' }
SRSqueakXRHelpersTest >> test3DToRaylibVector [

	| vec2 vec2Rl vec2RlExt |
	self assert: false description: 'test is wrong, vec2 must be converted before checking equality in asserts'.
	[vec2 :=  (1 @ 2) asVector.
	vec2Rl := RlVector2 new x: 1; y: 2.
	vec2RlExt := RlVector2 externalNew x: 1; y: 2.
	
	self assert: vec2 x = vec2Rl x.
	self assert: vec2 y = vec2Rl y.
	
	self assert: vec2 x = vec2RlExt x.
	self assert: vec2 y = vec2RlExt y.]
		ensure: [vec2RlExt ifNotNil: [vec2RlExt free]]
]

{ #category : #'as yet unclassified' }
SRSqueakXRHelpersTest >> testMatrix4x4Scale [

	| matrix |
	matrix := (Matrix4x4 withScale: 2 @ 3 @ 4).
	
	self assert: matrix scale = (2 @ 3 @ 4).
]

{ #category : #'as yet unclassified' }
SRSqueakXRHelpersTest >> testPointAsVector [

	self assert: (1 @ 2) asVector = (Vector2 x: 1 y: 2)
]

{ #category : #'as yet unclassified' }
SRSqueakXRHelpersTest >> testSwizzle [

	| vec2 vec3 vec4 |
	vec2 := (1 @ 2) asVector.
	vec3 := 1 @ 2 @ 3.
	vec4 := 1 @ 2 @ 3 @ 4.
	
	self assert: vec2 xx = (1 @ 1) asVector.
	self assert: vec2 yx = (2 @ 1) asVector.
	
	self assert: vec3 yyy = (2 @ 2 @ 2).
	self assert: vec3 zxy = (3 @ 1 @ 2).
	
	self assert: vec4 wzyx = (4 @ 3 @ 2 @ 1).
	self assert: vec4 yy = (2 @ 2) asVector.
	self assert: vec4 w = 4.
]
