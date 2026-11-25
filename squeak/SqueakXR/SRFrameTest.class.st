"
Tests how a frame keeps track of its views.
"
Class {
	#name : #SRFrameTest,
	#superclass : #TestCase,
	#instVars : [
		'frame'
	],
	#category : #'SqueakXR-Tests-Core',
	#'squeak_changestamp' : '<historical>'
}

{
	#category : #running,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:35'
}
SRFrameTest >> setUp [

	super setUp.
	frame := SRFrame world: SRWorld new deltaTime: 0.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:35'
}
SRFrameTest >> testAResumedFrameContinuesItsOpenView [

	frame renderObjects.
	frame needsView.
	frame viewOpened.
	frame renderObjects.
	self assert: frame needsView.
	self assert: frame isViewOpen.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:35'
}
SRFrameTest >> testAResumedFrameSkipsTheViewsItFinished [

	frame renderObjects.
	self assert: frame needsView.
	frame viewOpened.
	frame closeViewWith: [].
	frame renderObjects.
	self deny: frame needsView.
	self assert: frame needsView.
]

{
	#category : #tests,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:35'
}
SRFrameTest >> testAViewIsClosedOnlyOnce [

	| closings |
	closings := 0.
	frame viewOpened.
	frame closeViewWith: [closings := closings + 1].
	frame closeViewWith: [closings := closings + 1].
	self assert: closings = 1.
]
