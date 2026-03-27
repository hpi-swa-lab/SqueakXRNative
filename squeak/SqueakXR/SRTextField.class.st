Class {
	#name : #SRTextField,
	#superclass : #SRObject,
	#instVars : [
		'textPanel'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:23'
}
SRTextField >> initialize [

	super initialize.
	
	textPanel := SRMorphPanel new morph: PluggableTextMorph new.
	textPanel morph extent: 200 asPoint.
	textPanel
		rotation: (Quaternion angle: -90 axis: Vector3 right);
		scale: Vector3 one * SRMorphPanel defaultPixelsPerMeter / textPanel morph extent x.
	self addChild: textPanel.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:04'
}
SRTextField >> text: aString [

	textPanel morph setText: aString
]
