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
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:09'
}
SRResizerTest >> testDragKeepsOppositeCornerFixed [
	"Solving against the anchor rather than the panel origin is what keeps a drag
	from oscillating with period two."

	| resizer anchor |
	resizer := self resizerOn: 400@300.
	anchor := resizer anchorPosition.
	resizer wasGrabbed.
	resizer resizeToSpan: 1.2 @ -0.8 @ 0.
	self assert: anchor equals: resizer anchorPosition.
	resizer resizeToSpan: 1.2 @ -0.8 @ 0.
	self assert: anchor equals: resizer anchorPosition
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:09'
}
SRResizerTest >> testDragResizesMorph [

	| resizer |
	resizer := self resizerOn: 400@300.
	resizer wasGrabbed.
	resizer resizeToSpan: 1.2 @ -0.8 @ 0.
	self assert: 600@400 equals: resizer panel morph extent
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 14:09'
}
SRResizerTest >> testDragStopsAtMinimumExtent [

	| resizer |
	resizer := self resizerOn: 400@300.
	resizer wasGrabbed.
	resizer resizeToSpan: 0.001 @ -0.001 @ 0.
	self assert: SRResizer minimumExtent equals: resizer panel morph extent
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 8/12/2026 16:59'
}
SRResizerTest >> testReleaseStopsDragging [

	| resizer |
	resizer := self resizerOn: 400@300.
	resizer wasGrabbed.
	resizer wasReleased.
	self deny: resizer isDragging
]
