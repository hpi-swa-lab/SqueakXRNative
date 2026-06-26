Class {
	#name : #SqueakXRExtensionsTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Helpers'
}

{
	#category : #support,
	#'squeak_changestamp' : 'lege 3/19/2026 14:42'
}
SqueakXRExtensionsTest >> assertMatrix: aMatrix4x4 closeTo: aMatrixCollection [
	
	self assert: (aMatrix4x4 closeTo: (Matrix4x4 newFrom: aMatrixCollection))
]

{
	#category : #'testing-matrix4x4',
	#'squeak_changestamp' : 'lege 3/19/2026 14:45'
}
SqueakXRExtensionsTest >> testMatrix4x4FromQuaternion [

	| m |
	m := Matrix4x4 fromQuaternion: (Quaternion angle: 90 axis: 0 @ 1 @ 0).
	self assertMatrix: m closeTo: #(
		 0  0  1  0
		 0  1  0  0
		-1  0  0  0
		 0  0  0  1
	).
]

{
	#category : #'testing-matrix4x4',
	#'squeak_changestamp' : 'lege 3/19/2026 14:49'
}
SqueakXRExtensionsTest >> testMatrix4x4ObjectLookAt [

	| m |
	m := Matrix4x4 objectLookAt: 0 @ 0 @ 0 from: 1 @ 0 @ 0 up: 0 @ 1 @ 0.
	self assertMatrix: m closeTo: #(
		 0  0 -1  1
		 0  1  0  0
		-1  0  0  0
		 0  0  0  1
	).
]

{
	#category : #'testing-quaternion',
	#'squeak_changestamp' : 'lege 1/22/2026 17:13'
}
SqueakXRExtensionsTest >> testQuaternionCloseTo [

	self assert:
		((Quaternion
			a: 0
			b: 1
			c: 0
			d: 0)
		closeTo:
		(Quaternion
			a: 0.00001
			b: 1.00001
			c: 0.00001
			d: 0.00001)).
	
	self deny:
		((Quaternion
			a: 1
			b: 0
			c: 0
			d: 0)
		closeTo:
		(Quaternion
			a: 0
			b: 1
			c: 0
			d: 0))
]

{
	#category : #'testing-quaternion',
	#'squeak_changestamp' : 'lege 1/22/2026 17:13'
}
SqueakXRExtensionsTest >> testQuaternionDeltaTo [

	| q1 q2 |
	q1 := Quaternion angle: 20 axis: 1 @ 0 @ 0.
	
	self assert: (q1 deltaTo: q1) equals: Quaternion identity.
	
	q2 := Quaternion angle: 60 axis: 1 @ 0 @ 0.
	
	self assert: ((q1 deltaTo: q2) closeTo: (Quaternion angle: 40 axis: 1 @ 0 @ 0)).
]

{
	#category : #'testing-quaternion',
	#'squeak_changestamp' : 'lege 1/22/2026 16:38'
}
SqueakXRExtensionsTest >> testQuaternionInverse [

	self assert: (Quaternion angle: 90 axis: 1 @ 0 @ 0) inverse
		equals: (Quaternion angle: -90 axis: 1 @ 0 @ 0) 
]

{
	#category : #'testing-quaternion',
	#'squeak_changestamp' : 'SqueakXR 6/26/2026 16:25'
}
SqueakXRExtensionsTest >> testQuaternionRotateVector [

	"The identity quaternion leaves a vector unchanged."
	self assert:
		(((Quaternion new setIdentity) rotateVector: 3 @ -2 @ 5)
		closeTo: 3 @ -2 @ 5).

	"A 90 degree rotation about Z maps the X axis onto the Y axis."
	self assert:
		(((Quaternion angle: 90 axis: 0 @ 0 @ 1) rotateVector: 1 @ 0 @ 0)
		closeTo: 0 @ 1 @ 0).

	"A 90 degree rotation about X maps the Y axis onto the Z axis."
	self assert:
		(((Quaternion angle: 90 axis: 1 @ 0 @ 0) rotateVector: 0 @ 1 @ 0)
		closeTo: 0 @ 0 @ 1).

	"Rotating about an axis leaves a vector along that axis unchanged."
	self assert:
		(((Quaternion angle: 47 axis: 0 @ 1 @ 0) rotateVector: 0 @ 3 @ 0)
		closeTo: 0 @ 3 @ 0).

	"Rotation preserves vector length."
	self assert:
		((((Quaternion angle: 33 axis: 1 @ 2 @ 3) rotateVector: 4 @ -1 @ 2) length)
		closeTo: (4 @ -1 @ 2) length)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 1/12/2026 14:10'
}
SqueakXRExtensionsTest >> testScreamingSnakeCaseToCamelCase [

	self assert: 'SCREAMING_SNAKE_CASE' screamingSnakeCaseToCamelCase
		equals: 'screamingSnakeCase'.
	self assert: 'TEST' screamingSnakeCaseToCamelCase
		equals: 'test'.
	self assert: '' screamingSnakeCaseToCamelCase
		equals: ''.
]

{
	#category : #'testing-string',
	#'squeak_changestamp' : 'lege 1/22/2026 14:48'
}
SqueakXRExtensionsTest >> testStringScreamingSnakeCaseToCamelCase [

	self assert: 'SCREAMING_SNAKE_CASE' screamingSnakeCaseToCamelCase
		equals: 'screamingSnakeCase'.
	self assert: 'TEST' screamingSnakeCaseToCamelCase
		equals: 'test'.
	self assert: '' screamingSnakeCaseToCamelCase
		equals: ''.
]
