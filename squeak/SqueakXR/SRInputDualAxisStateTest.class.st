Class {
	#name : #SRInputDualAxisStateTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Input'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 8/5/2026 17:38'
}
SRInputDualAxisStateTest >> testDeadzone [

	| state |
	state := SRInputDualAxisState new.
	
	state horizontal: 0.01.
	state vertical: 0.01.
	self assert: state horizontal equals: 0;
		assert: state vertical equals: 0;
		assert: state vector equals: 0 @ 0;
		assert: state realHorizontal equals: 0.01;
		assert: state realVertical equals: 0.01;
		assert: state realVector equals: 0.01 @ 0.01.
	
	state horizontal: 0.9.
	state vertical: 0.9.
	self assert: state horizontal equals: 0.9;
		assert: state vertical equals: 0.9;
		assert: state vector equals: 0.9 @ 0.9;
		assert: state realHorizontal equals: 0.9;
		assert: state realVertical equals: 0.9;
		assert: state realVector equals: 0.9 @ 0.9.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 11:27'
}
SRInputDualAxisStateTest >> testDeadzoneIsSymmetric [
	"Comparing the signed value against the deadzone silently discarded every
	leftward and backward push, so a thumbstick only worked in one quadrant."

	| state |
	state := SRInputDualAxisState new.

	state horizontal: -0.9.
	state vertical: -0.9.
	self assert: state horizontal equals: -0.9;
		assert: state vertical equals: -0.9;
		assert: state vector equals: -0.9 @ -0.9.

	state horizontal: -0.01.
	state vertical: -0.01.
	self assert: state horizontal equals: 0;
		assert: state vertical equals: 0;
		assert: state vector equals: 0 @ 0;
		assert: state realVector equals: -0.01 @ -0.01.
]
