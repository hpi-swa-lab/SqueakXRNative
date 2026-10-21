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
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/20/2026 18:04'
}
SRGhostAvatar >> anchors [

	^ Array with: headAnchor with: leftAnchor with: rightAnchor
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'MCPServer (jl) 10/21/2026 12:40'
}
SRGhostAvatar >> initialize [

	super initialize.

	headAnchor := SRObject new name: 'GhostHeadAnchor'.
	headAnchor addChild: (
		SRCube new
			color: Color gray;
			scale: 10cm asVector3;
			name: 'GhostHead').
	"On the face, which is -z: the head anchor carries the camera pose and
	Vector3 forward is -z. These used to read +5.5cm, which worked only while
	SRAvatarCamera negated the pose's third column."
	headAnchor addChild: (
		SRCube new
			color: Color white;
			scale: 2cm @ 2cm @ 0.5cm;
			translation: -2cm @ 1cm @ -5.5cm;
			name: 'GhostLeftEye').
	headAnchor addChild: (
		SRCube new
			color: Color white;
			scale: 2cm @ 2cm @ 0.5cm;
			translation: 2cm @ 1cm @ -5.5cm;
			name: 'GhostRightEye').
	headAnchor addChild: (
		SRCube new
			color: Color black;
			scale: 1cm @ 1cm @ 0.25cm;
			translation: -2cm @ 1cm @ -5.8cm;
			name: 'GhostLeftPupil').
	headAnchor addChild: (
		SRCube new
			color: Color black;
			scale: 1cm @ 1cm @ 0.25cm;
			translation: 2cm @ 1cm @ -5.8cm;
			name: 'GhostRightPupil').
	
	"Where the head is looking. One bar rather than a full SRAxes: a basis drawn
	on a 10 cm head is three bars crossing at the eyes, and the only question
	being asked of a ghost is which way it faces. The hands answer it already
	with their ray bars."
	headAnchor addChild: (
		SRCube new
			color: Color yellow;
			scale: 1cm @ 1cm @ 50cm;
			translation: Vector3 forward * 25cm;
			name: 'GhostGaze').

	leftAnchor := SRObject new name: 'GhostLeftHandAnchor'.
	leftAnchor addChild: (
		SRCube new
			color: Color blue;
			scale: 10cm asVector3;
			name: 'GhostLeftHand').
	leftAnchor addChild: (
		SRCube new
			color: SRHand leftRayColor;
			scale: 1cm @ 1cm @ 10m;
			translation: Vector3 forward * 5m;
			name: 'GhostLeftRay').
	
	rightAnchor := SRObject new name: 'GhostRightHandAnchor'.
	rightAnchor addChild: (
		SRCube new
			color: Color red;
			scale: 10cm asVector3;
			name: 'GhostRightHand').
	rightAnchor addChild: (
		SRCube new
			color: SRHand rightRayColor;
			scale: 1cm @ 1cm @ 10m;
			translation: Vector3 forward * 5m;
			name: 'GhostRightRay').
	
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
