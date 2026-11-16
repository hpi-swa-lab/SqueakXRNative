"
Drives SRResizer without a world: a panel plus a Morph is enough to exercise the drag geometry.
"
Class {
	#name : #SRResizerTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Morphic',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #private,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:48'
}
SRResizerTest >> hitsOn: aPanel at: aVector3 [

	^ (SRRay origin: aVector3 + (0 @ 0 @ 2m) forward: 0 @ 0 @ -1)
		castAllObjects: (aPanel allDescendantsSelect: [:each | each collisionGeometry notNil and: [each ignoreCollision not]])
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:09'
}
SRResizerTest >> resizerOn: anExtent [

	| panel |
	panel := SRMorphPanel new morph: (Morph new extent: anExtent); yourself.
	^ panel addResizerAt: #bottomRight
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:48'
}
SRResizerTest >> testAClickPassesThroughTheResizerButAGrabTakesIt [

	| resizer panel corner hand |
	resizer := self resizerOn: 400 @ 300.
	panel := resizer panel.
	corner := panel globalTransform localPointToGlobal: (resizer localPositionForSign: resizer cornerSign).
	hand := SRHand new.
	hand selectTargetsFrom: (self hitsOn: panel at: corner + (-1cm @ 1cm @ 0)).
	self assert: hand grabCandidate grabTarget == panel.
	hand selectTargetsFrom: (self hitsOn: panel at: resizer globalTranslation).
	self assert: hand grabCandidate grabTarget == resizer.
	self assert: hand cursorTarget isNil.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:28'
}
SRResizerTest >> testAResizerCanBeGrabbed [

	self assert: SRResizer new canGrab.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:43'
}
SRResizerTest >> testDragKeepsOppositeCornerFixed [
	"Solving against the anchor rather than the panel origin is what keeps a drag
	from oscillating with period two."

	| resizer anchor |
	resizer := self resizerOn: 400@300.
	anchor := resizer anchorPosition.
	resizer startGrabbing: nil.
	resizer resizeToSpan: 1.2 @ -0.8 @ 0.
	self assert: (anchor - resizer anchorPosition) length < 1e-6.
	resizer resizeToSpan: 1.2 @ -0.8 @ 0.
	self assert: (anchor - resizer anchorPosition) length < 1e-6.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:43'
}
SRResizerTest >> testDragResizesMorph [

	| resizer ppm |
	resizer := self resizerOn: 400@300.
	ppm := resizer panel pixelsPerMeter.
	resizer startGrabbing: nil.
	resizer resizeToSpan: (600 / ppm) @ (-400 / ppm) @ 0.
	self assert: 600@400 equals: resizer panel morph extent.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:36'
}
SRResizerTest >> testDragStopsAtMinimumExtent [

	| resizer |
	resizer := self resizerOn: 400@300.
	resizer startGrabbing: nil.
	resizer resizeToSpan: 0.001 @ -0.001 @ 0.
	self assert: SRResizer minimumExtent equals: resizer panel morph extent.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 13:48'
}
SRResizerTest >> testGrabbingTheHandleInPlaceKeepsTheExtent [

	| resizer |
	resizer := self resizerOn: 400 @ 300.
	resizer onGrabStarted: nil.
	resizer dragTo: resizer globalTransform.
	self assert: 400 @ 300 equals: resizer panel morph extent.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:41'
}
SRResizerTest >> testItsCubeIsHiddenUntilHovered [

	| resizer |
	resizer := SRResizer new.
	self deny: resizer children first visible.
	self deny: resizer isHovered.
	resizer onGrabStarted: nil.
	self assert: resizer isHovered.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (jl) 11/16/2026 11:37'
}
SRResizerTest >> testItsVisibleCubeGrabsTheResizer [

	| resizer |
	resizer := SRResizer new.
	self assert: resizer children first grabTarget == resizer.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 18:36'
}
SRResizerTest >> testReleaseStopsDragging [

	| resizer |
	resizer := self resizerOn: 400@300.
	resizer startGrabbing: nil.
	resizer stopGrabbing: nil.
	self deny: resizer isDragging.
]
