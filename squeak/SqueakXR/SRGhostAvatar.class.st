Class {
	#name : #SRGhostAvatar,
	#superclass : #SRObject,
	#instVars : [
		'headAnchor',
		'leftAnchor',
		'rightAnchor',
		'referenceAvatar'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/20/2026 16:15'
}
SRGhostAvatar >> initialize [

	super initialize.

	headAnchor := SRObject new name: 'GhostHeadAnchor'.
	headAnchor addChild: (
		SRCube new
			color: Color gray;
			scale: 10cm asVector3;
			name: 'GhostHead').
	headAnchor addChild: (
		SRCube new
			color: Color white;
			scale: 2cm @ 2cm @ 0.5cm;
			translation: -2cm @ 1cm @ 5.5cm;
			name: 'GhostLeftEye').
	headAnchor addChild: (
		SRCube new
			color: Color white;
			scale: 2cm @ 2cm @ 0.5cm;
			translation: 2cm @ 1cm @ 5.5cm;
			name: 'GhostRightEye').
	headAnchor addChild: (
		SRCube new
			color: Color black;
			scale: 1cm @ 1cm @ 0.25cm;
			translation: -2cm @ 1cm @ 5.8cm;
			name: 'GhostLeftPupil').
	headAnchor addChild: (
		SRCube new
			color: Color black;
			scale: 1cm @ 1cm @ 0.25cm;
			translation: 2cm @ 1cm @ 5.8cm;
			name: 'GhostRightPupil').
	
	leftAnchor := SRObject new name: 'GhostLeftHandAnchor'.
	leftAnchor addChild: (
		SRCube new
			color: Color blue;
			scale: 10cm asVector3;
			name: 'GhostLeftHand').
	leftAnchor addChild: (
		SRCube new
			color: Color cyan;
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m;
			name: 'GhostLeftRay').
	
	rightAnchor := SRObject new name: 'GhostRightHandAnchor'.
	rightAnchor addChild: (
		SRCube new
			color: Color red;
			scale: 10cm asVector3;
			name: 'GhostRightHand').
	rightAnchor addChild: (
		SRCube new
			color: (Color r: 1.0 g: 0.5 b: 0.5);
			scale: 1cm @ 1cm @ 10m;
			translation: 0 @ 0 @ -5m; name: 'GhostRightRay').
	
	self addChild: headAnchor;
		addChild: leftAnchor;
		addChild: rightAnchor.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 7/20/2026 16:19'
}
SRGhostAvatar >> referenceAvatar: anAvatar [

	referenceAvatar := anAvatar.
	
	headAnchor globalTransform: referenceAvatar camera globalTransform.
	leftAnchor globalTransform: referenceAvatar leftHand globalTransform.
	rightAnchor globalTransform: referenceAvatar rightHand globalTransform.
]
