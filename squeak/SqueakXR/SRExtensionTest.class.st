Class {
	#name : #SRExtensionTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/18/2026 16:41'
}
SRExtensionTest >> testRectangleRelativeTo [

	|  innerRect outerRect relativeRect |
	outerRect := Rectangle origin: 100 @ 200 extent: 100 @ 200.
	innerRect := Rectangle origin: 110 @ 290 extent: 20 @ 30.
	
	relativeRect := innerRect relativeTo: outerRect.
	self assert: relativeRect origin = (10 @ 90).
	self assert: relativeRect extent = (20 @ 30).
]
