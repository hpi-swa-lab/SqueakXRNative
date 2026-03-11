Class {
	#name : #SqueakXRExtensionsTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Helpers'
}

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
