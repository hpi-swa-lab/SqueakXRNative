"
A drag handle on one corner of an SRMorphPanel
"
Class {
	#name : #SRResizer,
	#superclass : #SRObject,
	#instVars : [
		'panel',
		'corner',
		'dragging',
		'anchor',
		'cube'
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
	#'squeak_changestamp' : 'jl 8/12/2026 17:29'
}
SRResizer class >> minimumExtent [
	"just an arbitrary minimal extent"

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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:01'
}
SRResizer >> color [

	^ cube color
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:02'
}
SRResizer >> color: aColor [

	cube color: aColor.
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:48'
}
SRResizer >> corner: aSymbol [

	corner := aSymbol.
	self name: 'Resizer ', aSymbol.
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:32'
}
SRResizer >> finishResize [
	"A full texture rebuild is too expensive to do per frame."

	panel ifNil: [^ self].
	panel fullTextureUpdate.
	self snapToCorner.
]

{
	#category : #initialization,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:01'
}
SRResizer >> initialize [

	super initialize.
	dragging := false.
	anchor := nil.
	self scale: self class handleSize asVector3.
	cube := SRCube new
		color: Color orange;
		yourself.
	self addChild: cube.
	corner := #bottomRight.
	self name: 'Resizer ', corner.
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:32'
}
SRResizer >> keepAnchorFixed [
	"Idempotent: re-running with an unchanged extent leaves the panel where it is."

	| offset |
	anchor ifNil: [^ self].
	offset := panel globalTransform localDirToGlobal:
		(self localPositionForSign: self oppositeCornerSign).
	panel globalTranslation: anchor - offset.
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'jl 8/12/2026 17:25'
}
SRResizer >> localPositionForSign: aPoint [
	| morph ppm |
	morph := panel morph.
	ppm := panel pixelsPerMeter.
	^ (aPoint x * morph width / ppm / 2) @ (aPoint y * morph height / ppm / 2) @ 0
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:36'
}
SRResizer >> onGrabStarted: aHand [

	"Pinned once: recomputing per frame would make the anchor chase the panel."
	anchor := (panel notNil and: [panel morph notNil])
		ifTrue: [self anchorPosition]
		ifFalse: [nil].
	dragging := true.
]

{
	#category : #dragging,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:36'
}
SRResizer >> onGrabStopped: aHand [
	"The release is handled inside a frame and #fullTextureUpdate rescales the plane."

	dragging ifFalse: [^ self].
	dragging := false.
	anchor := nil.
	self world
		ifNil: [self finishResize]
		ifNotNil: [:aWorld | aWorld addDeferredFrameMessage: [self finishResize]].
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'jl 8/12/2026 17:28'
}
SRResizer >> oppositeCornerSign [
	
	^  self cornerSign negated
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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:48'
}
SRResizer >> panel: aSRMorphPanel [

	panel := aSRMorphPanel.
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'jl 8/12/2026 17:25'
}
SRResizer >> resizeToSpan: aVector3 [
	"aVector3 runs from the pinned corner to the hand, in the panel's local frame, so
	it spans the whole panel. Measuring from the origin instead would oscillate."

	| morph extent |
	panel ifNil: [^ self].
	morph := panel morph.
	morph ifNil: [^ self].
	extent := (aVector3 asPoint * self cornerSign * panel pixelsPerMeter) rounded max: self class minimumExtent.

	extent = morph extent ifFalse: [
		morph extent: extent.
		"The Morph may refuse the exact extent; everything below reads back what it took."
		panel updatePlaneSize].
	self keepAnchorFixed.
	panel snapResizers
]

{
	#category : #geometry,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 17:48'
}
SRResizer >> snapToCorner [
	

	self position: (self localPositionForSign: self cornerSign).
]
