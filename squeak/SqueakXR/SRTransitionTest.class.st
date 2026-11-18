"
Tests SRTransition curves.
"
Class {
	#name : #SRTransitionTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Tween',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testBounceTouchesTheEndBeforeFinishing [

	self assert: ((SRTransition bounce value: 1 / 2.75 ease: #out) closeTo: 1)
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testEveryCurveStartsAtZeroAndEndsAtOne [

	SRTransition all do: [:transition |
		SRTransition eases do: [:ease |
			self assert: ((transition value: 0 ease: ease) closeTo: 0).
			self assert: ((transition value: 1 ease: ease) closeTo: 1)]]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testInOutEasesBothHalves [

	self assert: (SRTransition cubic value: 0.25 ease: #inOut) equals: 0.0625.
	self assert: (SRTransition cubic value: 0.75 ease: #inOut) equals: 0.9375.
	self assert: (SRTransition cubic value: 0.25 ease: #outIn) equals: 0.4375
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testInStartsSlowAndOutStartsFast [

	self assert: (SRTransition quad value: 0.5 ease: #in) equals: 0.25.
	self assert: (SRTransition quad value: 0.5 ease: #out) equals: 0.75
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testLinearIgnoresTheEase [

	SRTransition eases do: [:ease |
		self assert: ((SRTransition linear value: 0.3 ease: ease) closeTo: 0.3)]
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testOvershootingCurvesLeaveTheRange [

	self assert: (SRTransition back value: 0.2 ease: #in) < 0.
	self assert: (SRTransition elastic value: 0.5 ease: #out) > 1.
	self assert: (SRTransition spring value: 0.5 ease: #out) > 1
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/18/2026 17:24'
}
SRTransitionTest >> testUnknownEaseIsAnError [

	self should: [SRTransition linear value: 0.5 ease: #sideways] raise: Error
]
