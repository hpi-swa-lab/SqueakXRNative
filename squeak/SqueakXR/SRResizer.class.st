"
A drag handle that resizes an SRMorphPanel.

I am a small cube parked on one corner of my panel's morph. Which corner is my #corner: one of #topLeft #topRight #bottomLeft #bottomRight. A panel normally carries all four of me.

Grab me with a hand and drag: SRHand writes my #globalTransform: once per frame, and that is the only notification of the drag I get. I intercept it, turn the hand's position into a new Morph extent, and stay snapped to my corner rather than following the hand freely. On release I do a full texture update, which is the expensive part and therefore not done per frame.

The corner diagonally opposite me stays pinned where it was when the grab started, so the panel moves as well as resizes. That anchor is captured once in #wasGrabbed and the new size is solved directly against it. Measuring the span from the panel's origin and then correcting the origin afterwards would NOT converge -- it oscillates with period two, since each correction invalidates the next measurement.

I deliberately do NOT set #grabTarget: to my panel: if I did, grabbing me would move the panel instead of resizing it.

Add and remove me through SRMorphPanel>>addResizers / removeResizers, or the panel's 'Resize' context menu item.
"
Class {
	#name : #SRResizer,
	#superclass : #SRObject,
	#instVars : [
		'panel',
		'corner',
		'color',
		'dragging',
		'anchor'
	],
	#category : #'SqueakXR-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer class >> corners [
	"The corners a resizer can sit on, named as the Morph sees them."

	^ #(#topLeft #topRight #bottomLeft #bottomRight)
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer class >> handleSize [
	"Edge length of the handle cube, in meters."

	^ 0.06
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer class >> minimumExtent [
	"Below this a dragged-to-nothing panel becomes impossible to grab again."

	^ 120 @ 80
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> anchorPosition [
	"World position of the corner opposite mine, the one a drag holds still."

	^ panel globalTransform localPointToGlobal:
		(self localPositionForSign: self oppositeCornerSign)
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> collisionGeometry [
	"Without this a hand ray passes straight through me and I can never be grabbed."

	^ SRCollisionBox new
		center: self globalTranslation;
		halfExtents: self globalScale / 2.0;
		rotation: self globalRotation;
		object: self
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> color [

	^ color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> color: aColor [

	color := aColor
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> corner [

	^ corner
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> corner: aSymbol [

	(self class corners includes: aSymbol)
		ifFalse: [^ self error: 'Not a corner: ', aSymbol printString].
	corner := aSymbol.
	self name: 'Resizer ', aSymbol.
	self snapToCorner
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> cornerSign [
	"Which way my corner lies from the panel's origin, as a Point of +1/-1.
	x is +1 right, y is +1 towards the morph's TOP: the panel's plane is rotated 90
	degrees about X, which flips the morph's downwards into the panel's +y."

	^ corner caseOf: {
		[#topLeft] -> [-1 @ 1].
		[#topRight] -> [1 @ 1].
		[#bottomLeft] -> [-1 @ -1].
		[#bottomRight] -> [1 @ -1] }
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> finishResize [
	"Drag over: rebuild the whole texture once, instead of per frame."

	panel ifNil: [^ self].
	panel fullTextureUpdate.
	self snapToCorner
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> globalTransform: aMatrix4x4 [
	"SRHand>>step: writes this every frame while it holds me, and it is the only
	notification of the drag I get. Rather than let it move me, read off where it
	wants my corner to be, resize the Morph to match, and snap back to the corner."

	| span |
	(dragging and: [anchor notNil]) ifFalse: [^ super globalTransform: aMatrix4x4].

	"Measured from the anchor, not from the panel origin, so that moving the panel
	below cannot disturb the next frame's measurement."
	span := panel globalTransform globalDirToLocal: aMatrix4x4 translation - anchor.
	self resizeToSpan: span
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> initialize [

	| size |
	super initialize.
	color := Color orange.
	dragging := false.
	anchor := nil.
	size := self class handleSize.
	self scale: size @ size @ size.
	self corner: #bottomRight.
]

{
	#category : #testing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> isDragging [

	^ dragging ifNil: [false]
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> keepAnchorFixed [
	"Shift the panel so the opposite corner lands back on the anchor. Idempotent:
	re-running it with an unchanged extent leaves the panel where it is."

	| offset |
	anchor ifNil: [^ self].
	offset := panel globalTransform localDirToGlobal:
		(self localPositionForSign: self oppositeCornerSign).
	panel globalTranslation: anchor - offset
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> localPositionForSign: aPoint [
	"Where the corner picked out by aPoint sits in the panel's local frame."

	| morph ppm |
	morph := panel morph.
	ppm := self pixelsPerMeter.
	^ (aPoint x * morph width / ppm / 2) @ (aPoint y * morph height / ppm / 2) @ 0
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> oppositeCornerSign [
	"The corner diagonally across from mine: the one that stays put while I drag."

	| sign |
	sign := self cornerSign.
	^ sign x negated @ sign y negated
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> panel [

	^ panel
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> panel: aSRMorphPanel [

	panel := aSRMorphPanel.
	self snapToCorner
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> pixelsPerMeter [

	^ SRMorphPanel defaultPixelsPerMeter
]

{
	#category : #rendering,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:43'
}
SRResizer >> renderOn: aSRRenderer [

	aSRRenderer renderCubeTransformed: self globalTransform withColor: self color
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> resizeToSpan: aVector3 [
	"aVector3 runs, in the panel's local frame, from the pinned opposite corner to
	where the hand wants me. It therefore spans the whole panel, so its components
	are the new width and height outright -- no halving, and no dependence on where
	the panel's origin currently is. That last part is what keeps the drag stable."

	| morph ppm sign minimum extent |
	panel ifNil: [^ self].
	morph := panel morph.
	morph ifNil: [^ self].
	ppm := self pixelsPerMeter.
	sign := self cornerSign.
	minimum := self class minimumExtent.
	extent := (sign x * aVector3 x * ppm) rounded @ (sign y * aVector3 y * ppm) rounded.
	extent := (extent x max: minimum x) @ (extent y max: minimum y).

	extent = morph extent ifFalse: [
		morph extent: extent.
		"The Morph may refuse the exact extent; everything below reads back what it took."
		panel setSizeFromPixelsPerMeter: ppm].
	self keepAnchorFixed.
	panel snapResizers
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> snapToCorner [
	"Sit on my corner of the morph. Verified against the plane: its mesh corner
	(0.5, 0, 0.5) -- which #handleRaycast: reads as the morph's bottom right --
	lands at panel-local (+width/2, -height/2, 0)."

	(panel isNil or: [panel morph isNil or: [corner isNil]]) ifTrue: [^ self].
	self position: (self localPositionForSign: self cornerSign)
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> wasGrabbed [

	"Pin the opposite corner once, here. Recomputing it per frame would make it
	chase the panel I am about to move."
	anchor := (panel notNil and: [panel morph notNil])
		ifTrue: [self anchorPosition]
		ifFalse: [nil].
	dragging := true
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/3/2026 17:59'
}
SRResizer >> wasReleased [
	"Deferred: the release is handled inside a frame and #fullTextureUpdate rescales
	the plane, same reason SRMorphPanel defers its 'Refresh Texture' menu action."

	dragging ifFalse: [^ self].
	dragging := false.
	anchor := nil.
	self world
		ifNil: [self finishResize]
		ifNotNil: [:aWorld | aWorld runBetweenFrames: [self finishResize]]
]
