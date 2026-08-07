Class {
	#name : #SRInputFloatStateTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:20'
}
SRInputFloatStateTest >> testIsJustPressed [

	| state |
	state := SRInputFloatState new.
	self deny: state isJustPressed.
	
	state updateValue: 0.99.
	self assert: state isJustPressed.
	
	state updateValue: 0.99.
	self deny: state isJustPressed.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:21'
}
SRInputFloatStateTest >> testIsJustReleased [

	| state |
	state := SRInputFloatState new.
	self deny: state isJustReleased.
	
	state updateValue: 0.99.
	self deny: state isJustReleased.
	
	state updateValue: 0.1.
	self assert: state isJustReleased.
	
	state updateValue: 0.1.
	self deny: state isJustReleased.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:18'
}
SRInputFloatStateTest >> testIsPressed [

	| state |
	state := SRInputFloatState new.
	self deny: state isPressed.
	
	state updateValue: 0.1.
	self deny: state isPressed.
	
	state updateValue: 0.99.
	self assert: state isPressed.
	
	state updateValue: 0.85.
	self assert: state isPressed.
	
	state updateValue: 0.1.
	self deny: state isPressed.
]
