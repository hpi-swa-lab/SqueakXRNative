Class {
	#name : #SRDamageRecorder,
	#superclass : #DamageRecorder,
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/17/2026 17:09'
}
SRDamageRecorder >> invalidRectsFullBounds: aRectangle [
	"Return a collection of damaged rectangles for the given canvas. If a total repaint has been requested, return the given rectangle."

	totalRepaint
		ifTrue: [^ Array with: aRectangle]
		ifFalse: [^ invalidRects keys].


]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 14:49'
}
SRDamageRecorder >> invalidRectsFullBoundsWithMorphs: aRectangle [
	"Return a collection of damaged rectangles for the given canvas. If a total repaint has been requested, return the given rectangle."

	totalRepaint
		ifTrue: [^ Dictionary newFromPairs: {aRectangle. invalidRects values flatten}]
		ifFalse: [^ invalidRects].

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/18/2026 17:50'
}
SRDamageRecorder >> recordInvalidRect: newRect from: aMorph [
	"Record the given rectangle in my damage list, a list of rectangular areas of the display that should be redraw on the next display cycle."
	"Details: Damaged rectangles are often identical or overlap significantly. In these cases, we merge them to reduce the number of damage rectangles that must be processed when the display is updated. Moreover, above a certain threshold, we ignore the individual rectangles completely, and simply do a complete repaint on the next cycle."
	
	| mergeRect |

	totalRepaint ifTrue: [^ self].  "planning full repaint; don't bother collecting damage"

	invalidRects keysAndValuesDo:
		[:rect :morphs |
		| a |
		((a := (rect intersect: newRect) area) > 40
			and: ["Avoid combining a vertical and horizontal rects.
				  Can make a big diff and we only test when likely."
				  a > (newRect area // 4) or: [a > (rect area // 4)]])
			ifTrue:
			["merge rectangle in place (see note below) if there is significant overlap"
			mergeRect := Rectangle
				origin: (rect origin min: newRect origin) truncated
				corner: (rect corner max: newRect corner) truncated.
			invalidRects removeKey: rect; add: mergeRect -> {aMorph. morphs} flatten.
			^ self]].


	invalidRects size >= 15 ifTrue: [| morphs |
		"if there are too many separate areas, merge them all"
		mergeRect := Rectangle merging: invalidRects keys.
		morphs := invalidRects values flatten.
		self reset.
		invalidRects add: mergeRect -> morphs].

	"add the given rectangle to the damage list"
	"Note: We make a deep copy of all rectangles added to the damage list,
		since rectangles in this list may be extended in place."
	invalidRects add:
		(newRect topLeft truncated corner: newRect bottomRight truncated) -> {aMorph}.

]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/16/2026 18:37'
}
SRDamageRecorder >> reset [

	invalidRects := Dictionary new: 15.
	totalRepaint := false.
]
