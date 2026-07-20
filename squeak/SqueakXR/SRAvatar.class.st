Class {
	#name : #SRAvatar,
	#superclass : #SRObject,
	#instVars : [
		'camera',
		'leftHand',
		'rightHand',
		'contextMenu',
		'ghostAvatar'
	],
	#category : #'SqueakXR-Objects'
}

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:49'
}
SRAvatar >> camera [

	^ camera
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 3/19/2026 14:50'
}
SRAvatar >> cameraPosition: position target: target up: up [

	camera globalTransform: (Matrix4x4 objectLookAt: target from: position up: up) 
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:09'
}
SRAvatar >> contextMenu [

	^ contextMenu
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:47'
}
SRAvatar >> enterOutOfBody [

	self assert: ghostAvatar isNil.
	
	ghostAvatar := SRGhostAvatar new referenceAvatar: self.
	self world addChild: ghostAvatar.
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:49'
}
SRAvatar >> exitOutOfBody [

	ghostAvatar ifNil: [^ self].
	
	ghostAvatar remove.
	ghostAvatar := nil.
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 7/3/2026 17:26'
}
SRAvatar >> hands [

	^ {self leftHand. self rightHand}
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 6/30/2026 17:19'
}
SRAvatar >> initialize [

	super initialize.
	
	leftHand := SRHand left avatar: self.
	rightHand := SRHand right avatar: self.
	camera := SRObject new name: 'Camera'.

	self addChild: leftHand;
		addChild: rightHand;
		addChild: camera.
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:50'
}
SRAvatar >> isOutOfBody [

	^ ghostAvatar notNil
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> leftHand [

	^ leftHand
]

{
	#category : #menu,
	#'squeak_changestamp' : 'lege 7/1/2026 15:46'
}
SRAvatar >> menuPlacementPositionForHand: aHand [
	"Place the menu in front of the camera, avoiding objects via a raycast from the hand."

	| viewer forward preferredDistance margin minDistance hit distance |
	viewer := camera globalTranslation.
	forward := (camera globalTransform localDirToGlobal: Vector3 forward) normalize.
	preferredDistance := 0.5.
	margin := 0.05.
	minDistance := 0.25.
	hit := aHand castRayBackward.
	distance := preferredDistance.
	hit ifNotNil: [
		| hitDistance |
		hitDistance := hit point distanceTo: viewer.
		distance := (hitDistance - margin) min: preferredDistance].
	distance := distance max: minDistance.
	^ viewer + (forward * distance)
]

{
	#category : #menu,
	#'squeak_changestamp' : 'lege 7/20/2026 18:36'
}
SRAvatar >> openContextMenuFor: anObject at: aPosition [

	^ contextMenu := SRMenu
		contextMenuFor: anObject
		at: aPosition
		facing: self camera globalTranslation
		in: self world
]

{
	#category : #menu,
	#'squeak_changestamp' : 'lege 7/2/2026 11:35'
}
SRAvatar >> openMenuForHand: aHand [
	"Notified by a hand that a menu should be spawned. If our menu is still open,
	close it. Otherwise open a context menu for the hand's grabbed object, or the
	world menu. A menu that was dismissed elsewhere (e.g. by selecting an item)
	has a nil parent, so it no longer counts as open."

	| position |
	(contextMenu notNil and: [contextMenu isOpen]) ifTrue: [
		contextMenu remove.
		contextMenu := nil.
		^ self].
	position := self menuPlacementPositionForHand: aHand.
	aHand grabbedObject
		ifNotNil: [:object | self openContextMenuFor: object at: position]
		ifNil: [self openWorldMenuAt: position].
]

{
	#category : #menu,
	#'squeak_changestamp' : 'lege 7/20/2026 18:36'
}
SRAvatar >> openWorldMenuAt: aPosition [

	^ contextMenu := SRMenu
		worldMenuAt: aPosition
		facing: self camera globalTranslation
		in: self world
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'lege 10/8/2025 17:50'
}
SRAvatar >> rightHand [

	^ rightHand
]

{
	#category : #'out-of-body',
	#'squeak_changestamp' : 'lege 7/20/2026 17:50'
}
SRAvatar >> toggleOutOfBody [

	self isOutOfBody
		ifTrue: [self exitOutOfBody]
		ifFalse: [self enterOutOfBody]
]
