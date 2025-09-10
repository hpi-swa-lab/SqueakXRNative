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
