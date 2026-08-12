Class {
	#name : #SRInputButtonStateTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:12'
}
SRInputButtonStateTest >> testIsJustPressed [

	| state |
	state := SRInputButtonState new.
	self deny: state isJustPressed.
	
	state isPressed: true.
	self assert: state isJustPressed.
	
	state isPressed: true.
	self deny: state isJustPressed.
	
	state isPressed: false.
	self deny: state isJustPressed.
	
	state isPressed: false.
	self deny: state isJustPressed.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:14'
}
SRInputButtonStateTest >> testIsJustReleased [

	| state |
	state := SRInputButtonState new.
	self deny: state isJustPressed.
	
	state isPressed: true.
	self deny: state isJustReleased.
	
	state isPressed: true.
	self deny: state isJustReleased.
	
	state isPressed: false.
	self assert: state isJustReleased.
	
	state isPressed: false.
	self deny: state isJustReleased.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:11'
}
SRInputButtonStateTest >> testIsPressed [

	| state |
	state := SRInputButtonState new.
	self deny: state isPressed.
	
	state isPressed: true.
	self assert: state isPressed.
	
	state isPressed: false.
	self deny: state isPressed.
]
