"
A drag handle on one corner of an SRMorphPanel
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
	#'squeak_changestamp' : 'jl 8/12/2026 16:24'
}

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer class >> corners [
	^ #(#topLeft #topRight #bottomLeft #bottomRight)
]

{
	#category : #constants,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer class >> handleSize [
	^ 6cm
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> anchorPosition [
	"The corner a drag holds still."

	^ panel globalTransform localPointToGlobal:
		(self localPositionForSign: self oppositeCornerSign)
]

{
	#category : #collisions,
	#'squeak_changestamp' : 'jl 8/12/2026 16:25'
}
SRResizer >> collisionGeometry [
	
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
	#'squeak_changestamp' : 'jl 8/12/2026 16:12'
}
SRResizer >> corner: aSymbol [

	corner := aSymbol.
	self name: 'Resizer ', aSymbol.
	self snapToCorner
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'jl 8/12/2026 16:11'
}
SRResizer >> cornerSign [
	"+y is the morph's TOP: the plane is rotated 90 degrees about X, which flips the
	MorphPanel's downwards into the panel's +y."

	^ corner caseOf: {
		[#topLeft] -> [-1 @ 1].
		[#topRight] -> [1 @ 1].
		[#bottomLeft] -> [-1 @ -1].
		[#bottomRight] -> [1 @ -1] }
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:49'
}
SRResizer >> dragTo: aMatrix4x4 [

	| span |
	(dragging and: [anchor notNil]) ifFalse: [^ super dragTo: aMatrix4x4].

	"Measured from the anchor, not from the panel origin, so that moving the panel
	below cannot disturb the next frame's measurement."
	span := panel globalTransform globalDirToLocal: aMatrix4x4 translation - anchor.
	self resizeToSpan: span.
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> finishResize [
	"A full texture rebuild is too expensive to do per frame."

	panel ifNil: [^ self].
	panel fullTextureUpdate.
	self snapToCorner
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> keepAnchorFixed [
	"Idempotent: re-running with an unchanged extent leaves the panel where it is."

	| offset |
	anchor ifNil: [^ self].
	offset := panel globalTransform localDirToGlobal:
		(self localPositionForSign: self oppositeCornerSign).
	panel globalTranslation: anchor - offset
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> localPositionForSign: aPoint [
	| morph ppm |
	morph := panel morph.
	ppm := self pixelsPerMeter.
	^ (aPoint x * morph width / ppm / 2) @ (aPoint y * morph height / ppm / 2) @ 0
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> oppositeCornerSign [
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> resizeToSpan: aVector3 [
	"aVector3 runs from the pinned corner to the hand, in the panel's local frame, so
	it spans the whole panel. Measuring from the origin instead would oscillate."

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
	#'squeak_changestamp' : 'jl 8/12/2026 16:27'
}
SRResizer >> snapToCorner [
	

	(panel isNil or: [panel morph isNil or: [corner isNil]]) ifTrue: [^ self].
	self position: (self localPositionForSign: self cornerSign)
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> wasGrabbed [

	"Pinned once: recomputing per frame would make the anchor chase the panel."
	anchor := (panel notNil and: [panel morph notNil])
		ifTrue: [self anchorPosition]
		ifFalse: [nil].
	dragging := true
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:10'
}
SRResizer >> wasReleased [
	"The release is handled inside a frame and #fullTextureUpdate rescales the plane."

	dragging ifFalse: [^ self].
	dragging := false.
	anchor := nil.
	self world
		ifNil: [self finishResize]
		ifNotNil: [:aWorld | aWorld addDeferredFrameMessage: [self finishResize]]
]
