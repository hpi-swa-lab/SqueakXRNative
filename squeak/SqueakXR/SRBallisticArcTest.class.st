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
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:43'
}
SRBallisticArcTest >> groundAtY: aNumber [
	"Scaled up: an SRPlane is bounded, and a default one is a square metre that
	every arc here would fly straight over."

	^ SRPlane new
		translation: 0 @ aNumber @ 0;
		scale: Vector3 one * 100;
		solid: true;
		yourself
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:39'
}
SRBallisticArcTest >> testAimingLowerLandsNearerAndHigherLandsFurther [
	"The whole point of an arc over a straight ray: the wrist chooses distance."

	| down level up |
	down := self arcFrom: 0 @ 1.6 @ 0 direction: (0 @ -1 @ -1) normalized.
	level := self arcFrom: 0 @ 1.6 @ 0 direction: 0 @ 0 @ -1.
	up := self arcFrom: 0 @ 1.6 @ 0 direction: (0 @ 0.6 @ -1) normalized.
	self assert: down hit point z abs < level hit point z abs.
	self assert: level hit point z abs < up hit point z abs.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:39'
}
SRBallisticArcTest >> testAnArcThatReachesNothingHasNoHit [
	"Pointing at the sky is not a place to stand, and the preview has to be able
	to say so."

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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:39'
}
SRBallisticArcTest >> testHorizontalThrowFallsToTheGround [
	"Also proves the segments are bounded: an unbounded ray from the first
	segment would meet the ground far away and end the arc at step one."

	| arc |
	arc := self arcFrom: 0 @ 1.6 @ 0 direction: 0 @ 0 @ -1.
	self assert: arc hit notNil.
	self assert: arc hit point y abs < 0.01.
	"1.6 m of fall at 10 m/s is 5.7 m analytically; forward Euler overshoots."
	self assert: (arc hit point z + 6.0) abs < 0.5.
	self assert: arc points last = arc hit point.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (SqueakXR) 10/20/2026 13:36'
}
SRBallisticArcTest >> testTheArcFliesThroughAMenu [
	"A menu is hittable by a picking ray and is not a place to land, so the arc
	must pass through it and reach the floor behind."

	| root ground menu arc blocked |
	ground := self groundAtY: 0.
	menu := SRMenu new.
	menu addItem: 'Row' action: [].
	root := SRObject new.
	root addChild: ground.
	root addChild: menu.
	menu rebuild.
	menu translation: 0 @ 1.502 @ -2.

	"Not vacuous: an unfiltered cast along the same segment does hit the menu."
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
