"
The blink is only worth having if the action happens while the view is actually black. These tests pin the ordering, which no amount of looking at the headset can confirm.
"
Class {
	#name : #SRBlinkOverlayTest,
	#superclass : #TestCase,
	#category : #'SqueakXR-Tests-Objects',
	#'squeak_changestamp' : '<historical>'
}

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
