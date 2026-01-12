Class {
	#name : #SqueakXRExtensionsTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Helpers'
}

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
