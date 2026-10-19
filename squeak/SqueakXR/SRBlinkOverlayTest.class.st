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
	#'squeak_changestamp' : 'MCPServer 10/19/2026 11:23'
}
SRBlinkOverlayTest >> setUp [
	"These tests step a fixed number of frames, so a fade time tuned in the live
	world would fail them. Saved from the class variables, not the getters: nil
	is the documented 'use the code default'."

	super setUp.
	savedFadeOut := SRBlinkOverlay classPool at: #FadeOutSeconds.
	savedFadeIn := SRBlinkOverlay classPool at: #FadeInSeconds.
	SRBlinkOverlay fadeOutSeconds: nil; fadeInSeconds: nil.
]

{
	#category : #running,
	#'squeak_changestamp' : 'MCPServer 10/19/2026 11:23'
}
SRBlinkOverlayTest >> tearDown [
	"Restored even when a test fails, so running the tests never retunes the
	live blink."

	SRBlinkOverlay fadeOutSeconds: savedFadeOut; fadeInSeconds: savedFadeIn.
	super tearDown
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:58'
}
SRBlinkOverlayTest >> testASecondBlinkDoesNotStrandTheFirstAction [
	"Two teleports in quick succession must both happen, or the player ends up
	somewhere they did not choose."

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
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:58'
}
SRBlinkOverlayTest >> testTheActionRunsOnlyWhenTheViewIsFullyBlack [
	"The whole point: the world may only move behind a closed eye."

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
	#'squeak_changestamp' : 'MCPServer 10/19/2026 11:15'
}
SRBlinkOverlayTest >> testTheFadeTimesAreThePreferences [
	"setUp nils the class variables, so an unset preference must read as the
	literal in the code rather than whatever the live world was tuned to."

	| overlay |
	self assert: SRBlinkOverlay fadeOutSeconds equals: 0.1.
	self assert: SRBlinkOverlay fadeInSeconds equals: 0.2.
	SRBlinkOverlay fadeOutSeconds: 2.0.
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [].
	30 timesRepeat: [overlay step: 10].
	self assert: overlay isBlinking.
	"Opacity is stored as a Color alpha, which is 8 bit, so 0.15 reads back as 38/255."
	self assert: (overlay opacity - 0.15) abs < (1 / 255).
]

{
	#category : #tests,
	#'squeak_changestamp' : 'MCPServer 10/16/2026 15:58'
}
SRBlinkOverlayTest >> testTheOverlayEndsInvisibleAndIdle [
	"A blink that forgot to clear itself would leave the player in the dark."

	| overlay |
	overlay := SRBlinkOverlay new.
	overlay blinkThen: [].
	100 timesRepeat: [overlay step: 10].
	self deny: overlay isBlinking.
	self assert: overlay opacity equals: 0.0.
	self deny: overlay children first visible.
]
