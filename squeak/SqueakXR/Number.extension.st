Extension { #name : #Number }

{
	#category : #'*SqueakXR-helpers',
	#'squeak_changestamp' : 'leo 10/19/2026 16:27'
}
Number >> asUnitString [

	| magnitude return |
	return := [:value :unit | ^ value asString, unit].
	self >= 1000 ifTrue: [return value: self / 1000.0 value: 'km'].
	magnitude := self log.
	magnitude >= 0 ifTrue: [return value: self value: 'm'].
	magnitude abs ceiling caseOf: {
		[1] -> [return value: self * 10 value: 'dm'].
		[2] -> [return value: self * 100 value: 'cm'].
	} otherwise: [return value: self * 1000 value: 'mm'].
]

{ #category : #'*SqueakXR-helpers' }
Number >> asVector3 [

	^ Vector3 value: self
]

{ #category : #'*SqueakXR-helpers' }
Number >> cm [

	^ self * 0.01
]

{ #category : #'*SqueakXR-helpers' }
Number >> dm [

	^ self * 0.1
]

{ #category : #'*SqueakXR-helpers' }
Number >> km [

	^ self * 1000
]

{ #category : #'*SqueakXR-helpers' }
Number >> m [

	^ self
]

{ #category : #'*SqueakXR-helpers' }
Number >> mm [

	^ self * 0.001
]
