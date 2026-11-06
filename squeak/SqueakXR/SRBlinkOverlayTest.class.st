"
The blink is only worth having if the action happens while the view is actually black. These tests pin the ordering, which no amount of looking at the headset can confirm.
"
Class {
	#name : #SRBlinkOverlayTest,
	#superclass : #TestCase,
	#instVars : [
		'savedFadeIn',
		'savedFadeOut'
	],
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> setUp [

	super setUp.
	savedFadeOut := SRBlinkOverlay classPool at: #FadeOutSeconds.
	savedFadeIn := SRBlinkOverlay classPool at: #FadeInSeconds.
	SRBlinkOverlay fadeOutSeconds: nil; fadeInSeconds: nil.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> tearDown [

	SRBlinkOverlay fadeOutSeconds: savedFadeOut; fadeInSeconds: savedFadeIn.
	super tearDown
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> testASecondBlinkDoesNotStrandTheFirstAction [

	| overlay done |
	done := OrderedCollection new.
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [done add: #first].
	overlay step: 10.
	overlay blinkThen: [done add: #second].
	100 timesRepeat: [overlay step: 10].
	self assert: done asArray equals: #(#first #second).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> testTheActionRunsOnlyWhenTheViewIsFullyBlack [

	| overlay opacityWhenRun |
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [opacityWhenRun := overlay opacity].
	self assert: opacityWhenRun isNil.
	30 timesRepeat: [
		opacityWhenRun ifNil: [overlay step: 10]].
	self assert: opacityWhenRun equals: 1.0.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> testTheFadeTimesAreThePreferences [

	| overlay |
	self assert: SRBlinkOverlay fadeOutSeconds equals: 0.1.
	self assert: SRBlinkOverlay fadeInSeconds equals: 0.2.
	SRBlinkOverlay fadeOutSeconds: 2.0.
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [].
	30 timesRepeat: [overlay step: 10].
	self assert: overlay isBlinking.

	self assert: (overlay opacity - 0.15) abs < (1 / 255).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer (MCPServer) 10/21/2026 14:59'
}
SRBlinkOverlayTest >> testTheOverlayEndsInvisibleAndIdle [

	| overlay |
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [].
	100 timesRepeat: [overlay step: 10].
	self deny: overlay isBlinking.
	self assert: overlay opacity equals: 0.0.
	self deny: overlay children first visible.
]
