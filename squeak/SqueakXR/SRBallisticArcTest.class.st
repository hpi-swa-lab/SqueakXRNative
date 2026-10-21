"
Casts arcs against a real SRPlane rather than a test double, so the segment maths is exercised through the same collision path a teleport uses.
"
Class {
	#name : #SRBallisticArcTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:39'
}
SRBallisticArcTest >> arcFrom: aPoint direction: aVector [
	^ SRBallisticArc new
		origin: aPoint direction: aVector;
		castIn: (self groundAtY: 0);
		yourself
]

{
	#category : #fixture,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArcTest >> groundAtY: aNumber [

	^ SRPlane new
		translation: 0 @ aNumber @ 0;
		scale: Vector3 one * 100;
		solid: true;
		yourself
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArcTest >> testAimingLowerLandsNearerAndHigherLandsFurther [

	| down level up |
	down := self arcFrom: 0 @ 1.6 @ 0 direction: (0 @ -1 @ -1) normalized.
	level := self arcFrom: 0 @ 1.6 @ 0 direction: 0 @ 0 @ -1.
	up := self arcFrom: 0 @ 1.6 @ 0 direction: (0 @ 0.6 @ -1) normalized.
	self assert: down hit point z abs < level hit point z abs.
	self assert: level hit point z abs < up hit point z abs.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArcTest >> testAnArcThatReachesNothingHasNoHit [

	| arc |
	arc := SRBallisticArc new
		origin: 0 @ 1.6 @ 0 direction: 0 @ 1 @ 0;
		castIn: (SRObject new);
		yourself.
	self assert: arc hit isNil.
	self assert: arc points size > 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArcTest >> testHorizontalThrowFallsToTheGround [

	| arc |
	arc := self arcFrom: 0 @ 1.6 @ 0 direction: 0 @ 0 @ -1.
	self assert: arc hit notNil.
	self assert: arc hit point y abs < 0.01.

	self assert: (arc hit point z + 6.0) abs < 0.5.
	self assert: arc points last = arc hit point.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBallisticArcTest >> testTheArcFliesThroughAMenu [

	| root ground menu arc blocked |
	ground := self groundAtY: 0.
	menu := SRMenu new.
	menu addItem: 'Row' action: [].
	root := SRObject new.
	root addChild: ground.
	root addChild: menu.
	menu rebuild.
	menu translation: 0 @ 1.502 @ -2.

	blocked := (SRRay origin: 0 @ 1.6 @ -1 forward: (0 @ -0.098 @ -1) normalized)
		castNearest: root.
	self assert: blocked notNil.
	self assert: blocked object isMenuItem.

	arc := SRBallisticArc new
		origin: 0 @ 1.6 @ 0 direction: 0 @ 0 @ -1;
		castIn: root;
		yourself.
	self assert: arc hit notNil.
	self assert: ground == arc hit object.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:39'
}
SRBallisticArcTest >> testTheCurveRisesThenFallsWhenAimedUp [
	| arc heights apex |
	arc := self arcFrom: 0 @ 1.6 @ 0 direction: (0 @ 1 @ -1) normalized.
	heights := arc points collect: [:each | each y].
	apex := heights indexOf: (heights inject: heights first into: [:a :b | a max: b]).
	self assert: apex > 1.
	self assert: apex < heights size.
	2 to: apex do: [:i | self assert: (heights at: i) >= (heights at: i - 1)].
	apex + 1 to: heights size do: [:i | self assert: (heights at: i) <= (heights at: i - 1)].
]
