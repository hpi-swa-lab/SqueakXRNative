Class {
	#name : #SRSqueakXRHelpersTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:38'
}
SRSqueakXRHelpersTest >> test3DToRaylibVector [

	| vec2 vec2Rl vec2RlExt |
	[vec2 :=  (1 @ 2) asVector.
	vec2Rl := RlVector2 new x: 1; y: 2.
	vec2RlExt := RlVector2 externalNew x: 1; y: 2.
	
	self assert: vec2 x = vec2Rl x.
	self assert: vec2 y = vec2Rl y.
	
	self assert: vec2 x = vec2RlExt x.
	self assert: vec2 y = vec2RlExt y.]
		ensure: [vec2RlExt ifNotNil: [vec2RlExt free]]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRSqueakXRHelpersTest >> testAxisConstantsAreRightHanded [

	self assert: Vector3 right equals: (Vector3 forward cross: Vector3 up).
	self assert: Vector3 up equals: (Vector3 backward cross: Vector3 right).
	self assert: Vector3 backward equals: (Vector3 right cross: Vector3 up).
]

{ #category : #'as yet unclassified' }
SRSqueakXRHelpersTest >> testMatrix4x4Scale [

	| matrix |
	matrix := (Matrix4x4 withScale: 2 @ 3 @ 4).
	
	self assert: matrix scale = (2 @ 3 @ 4).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 15:00'
}
SRSqueakXRHelpersTest >> testObjectLookAtAgreesWithTheAxisConstants [

	| eye target m |
	eye := Vector3 x: 3 y: 2 z: 7.
	target := Vector3 x: 3 y: 2 z: 1.
	m := Matrix4x4 objectLookAt: target from: eye up: Vector3 up.
	self assert: ((m localDirToGlobal: Vector3 forward) dot: (eye directionTo: target)) > 0.999.
	self assert: (m localDirToGlobal: Vector3 right) equals: Vector3 right.
	self assert: (m localDirToGlobal: Vector3 up) equals: Vector3 up.
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
