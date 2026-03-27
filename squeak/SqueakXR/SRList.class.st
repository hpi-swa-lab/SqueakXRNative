Class {
	#name : #SRList,
	#superclass : #SRObject,
	#instVars : [
		'listPanel'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/26/2026 17:32'
}
SRList >> initialize [

	super initialize.
	
	listPanel := SRMorphPanel new morph: PluggableListMorphPlus new.
	listPanel morph extent: 200 asPoint.
	listPanel
		rotation: (Quaternion angle: -90 axis: Vector3 right);
		scale: Vector3 one * SRMorphPanel defaultPixelsPerMeter / listPanel morph extent x.
	self addChild: listPanel.
]
