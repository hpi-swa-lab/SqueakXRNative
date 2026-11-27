"
Tests IntenSelect+ scoring.
"
Class {
	#name : #SRIntenSelectTest,
	#superclass : #TestCase,
	#instVars : [
		'selector',
		'ray'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #helpers,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> contributionAt: aPoint [

	^ selector
		contributionOf: (SRRayProximity object: nil point: aPoint distance: (ray distanceTo: aPoint))
		along: ray
]

{
	#category : #running,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> setUp [

	selector := SRIntenSelect new.
	ray := SRRay origin: Vector3 zero forward: 0 @ 0 @ 1.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testBehindRayContributesNothing [

	self assert: (self contributionAt: 0 @ 0 @ -1 m) = 0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testFadedTargetIsDropped [

	selector updateScores: (Dictionary newFrom: {#a -> 1}) over: 1.
	selector updateScores: Dictionary new over: 10.
	self assert: selector target isNil.
	self assert: (selector scoreOf: #a) = 0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testHitContributesFully [

	self assert: ((self contributionAt: 0 @ 0 @ 3 m) closeTo: 1)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testNearerToRayContributesMore [

	self assert: (self contributionAt: 0 @ 10 cm @ 2 m) > (self contributionAt: 0 @ 30 cm @ 2 m)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testOutsideConeContributesNothing [

	self assert: (self contributionAt: 0 @ 2 m @ 1 m) = 0
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testScoreRisesGradually [

	selector updateScores: (Dictionary newFrom: {#a -> 1}) over: 0.05.
	self assert: (selector scoreOf: #a) > 0.
	self assert: (selector scoreOf: #a) < 1.
	self assert: selector target = #a
]

{
	#category : #tests,
	#'squeak_changestamp' : 'phkeese-MCPServer 11/27/2026 15:55'
}
SRIntenSelectTest >> testTargetIsSticky [

	selector updateScores: (Dictionary newFrom: {#a -> 1}) over: 1.
	selector updateScores: (Dictionary newFrom: {#a -> 0. #b -> 1}) over: 0.02.
	self assert: selector target = #a.
	selector updateScores: (Dictionary newFrom: {#a -> 0. #b -> 1}) over: 1.
	self assert: selector target = #b
]
