Class {
	#name : #SRXrActionStates,
	#superclass : #ExternalStructure,
	#category : #'SqueakXR-Core'
}

{ #category : #'as yet unclassified' }
SRXrActionStates class >> fields [

	" self defineFields "
	^ #(
		(aimPoses 'XrPosef[2]')
		(triggers 'float[2]')
		(squeeze 'float[2]')
		(a 'bool')
		(b 'bool')
		(x 'bool')
		(y 'bool')
		(menu 'bool')
		(thumbstickX 'float[2]')
		(thumbstickY 'float[2]')
	)
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'phkeese 8/6/2026 16:56'
}
SRXrActionStates >> thumbsticks [
	| x y output |
	x := self thumbstickX.
	y := self thumbstickY.
	output := Array new: (x size).
	1 to: (x size) do: [ :i |
		output at: i put: (x at: i)@(y at: i)
	].
	^ output 
]
