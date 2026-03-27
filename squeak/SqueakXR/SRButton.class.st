Class {
	#name : #SRButton,
	#superclass : #SRObject,
	#instVars : [
		'buttonPanel'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:35'
}
SRButton >> initialize [

	super initialize.
	
	buttonPanel := SRMorphPanel new morph: PluggableButtonMorphPlus new.
	buttonPanel morph extent: 200 asPoint.
	buttonPanel
		rotation: (Quaternion angle: -90 axis: Vector3 right);
		scale: Vector3 one * SRMorphPanel defaultPixelsPerMeter / buttonPanel morph extent x.
	self addChild: buttonPanel.
]
