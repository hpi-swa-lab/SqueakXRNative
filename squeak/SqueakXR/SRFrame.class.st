Class {
	#name : #SRFrame,
	#superclass : #Object,
	#instVars : [
		'world',
		'deltaTime',
		'steppedObjects',
		'isOld',
		'firstPassRenderedObjects',
		'secondPassRenderedObjects',
		'hasRenderingBegun',
		'isCompleted',
		'viewsDone',
		'viewsSeen',
		'isViewOpen',
		'renderPass',
		'renderIndex'
	],
	#classVars : [
		'FrameExceptionSet',
		'OverlaysOnTop'
	],
	#category : #'SqueakXR-Core'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/30/2026 15:38'
}
SRFrame class >> exceptionSet [

	^ FrameExceptionSet ifNil: [FrameExceptionSet := Error, Halt]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 18:53'
}
SRFrame class >> overlaysOnTop [
	<preference: 'Overlays on top'
		category: 'SqueakXR'
		description: 'Halos and gizmos clear the depth buffer and are drawn over everything, and the hand ray prefers them. Off, they are depth-tested like the scene and write no depth, so the depth handed to the compositor with each frame stays the scene''s.'
		type: #Boolean>
	^ OverlaysOnTop ifNil: [false]
]

{
	#category : #preferences,
	#'squeak_changestamp' : 'jl-MCPServer 11/25/2026 18:53'
}
SRFrame class >> overlaysOnTop: aBoolean [
	OverlaysOnTop := aBoolean.
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'leo 10/30/2026 15:38'
}
SRFrame class >> resetExceptionSet [

	FrameExceptionSet := nil
]

{ #category : #'as yet unclassified' }
SRFrame class >> world: world deltaTime: deltaTime [

	^ self new
		world: world;
		deltaTime: deltaTime;
		initializeObjectLists
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> closeViewWith: aBlock [
	"Also reached from the ensure: of a process held by the debugger, after another process finished the view."

	isViewOpen ifFalse: [^ self].
	isViewOpen := false.
	viewsDone := viewsDone + 1.
	aBlock value.
]

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:09'
}
SRFrame >> completeFrame [

	isCompleted = true ifTrue: [^ self].
	isCompleted := true.
	self world completeFrame.
]

{ #category : #accessing }
SRFrame >> deltaTime [

	^ deltaTime
]

{ #category : #accessing }
SRFrame >> deltaTime: aNumber [

	deltaTime := aNumber
]

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:03'
}
SRFrame >> handleError: anError [

	SRIsFrameContinuableVariable
		value: true
		during: [ToolSet handleError: anError].
	anError retry
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> hasRenderingBegun [

	^ hasRenderingBegun
]

{
	#category : #accessing,
	#'squeak_changestamp' : 'leo 9/30/2026 16:09'
}
SRFrame >> hasRenderingBegun: aBoolean [

	hasRenderingBegun := aBoolean
]

{
	#category : #'initialize-release',
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> initialize [

	self hasRenderingBegun: false.
	self isOld: false.
	isCompleted := false.
	viewsDone := 0.
	isViewOpen := false.
]

{
	#category : #initializing,
	#'squeak_changestamp' : 'MCPServer (leo) 11/2/2026 17:38'
}
SRFrame >> initializeObjectLists [

	| lights |
	"Side note, after a reset the buffers can still hold old objects.
	If the number of objects becomes very large in one frame,
	objects at the back of the buffer would not be GCed until
	the number rises to that amount again."
	steppedObjects := self world steppedObjectsBuffer reset.
	firstPassRenderedObjects := self world firstPassRenderBuffer reset.
	secondPassRenderedObjects := self world secondPassRenderBuffer reset.
	lights := self world lightsBuffer reset.
	self world allDo: [:object |
		object isStepping ifTrue: [steppedObjects add: object].
		object isShining ifTrue: [lights add: object].
		object isRendering ifTrue: [
			(object renderInSecondPass
				ifTrue: [secondPassRenderedObjects]
				ifFalse: [firstPassRenderedObjects]) add: object]].
]

{ #category : #accessing }
SRFrame >> isOld [

	^ isOld
]

{ #category : #accessing }
SRFrame >> isOld: aBoolean [

	isOld := aBoolean
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> isViewOpen [

	^ isViewOpen
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> needsView [
	"Views render in a fixed order, so a frame resumed after an error skips the ones it already drew."

	viewsSeen := viewsSeen + 1.
	^ viewsSeen > viewsDone
]

{
	#category : #processing,
	#'squeak_changestamp' : 'MCPServer (leo) 10/28/2026 18:03'
}
SRFrame >> prepareFrame [

	self hasRenderingBegun ifTrue: [^ self].
	self hasRenderingBegun: true.
	self world prepareFrame
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:36'
}
SRFrame >> process [

	self updateActions; stepObjects.
	[self prepareFrame; renderObjects] ensure: [self completeFrame].
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 16:59'
}
SRFrame >> renderObjects [

	viewsSeen := 0.
	self world rendererOrchestrator renderFrame: self.
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> renderObjects: aCollection on: aRenderer [
	"The index lives in the frame: a retry, or a process resuming this frame, goes on after the object that failed."

	[[renderIndex < aCollection size] whileTrue: [
		renderIndex := renderIndex + 1.
		(aCollection at: renderIndex) renderOn: aRenderer]]
		on: self class exceptionSet
		do: [:error |
			(aCollection at: renderIndex) badRender: true.
			self handleError: error]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> renderObjectsOn: aRenderer [

	renderPass = 1 ifTrue: [
		self renderObjects: firstPassRenderedObjects on: aRenderer.
		aRenderer clearDepth.
		renderPass := 2.
		renderIndex := 0].
	self renderObjects: secondPassRenderedObjects on: aRenderer.
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo 10/30/2026 15:39'
}
SRFrame >> stepObjects [

	
	| currentObject |
	[[steppedObjects notEmpty] whileTrue: [
		currentObject := steppedObjects removeFirst.
		"It's possible that the current object was removed in another step: call in this frame.
		Thus, we need to check if the object is still in the world before proceeding."
		currentObject world = self world ifTrue: [
			currentObject step: deltaTime]]]
		on: self class exceptionSet
		do: [:error |
			currentObject badStep: true.
			self handleError: error]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/22/2026 16:36'
}
SRFrame >> updateActions [

	isOld ifFalse: [self world updateActions: deltaTime]
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> viewOpened [

	isViewOpen := true.
	renderPass := 1.
	renderIndex := 0.
]

{
	#category : #processing,
	#'squeak_changestamp' : 'leo-MCPServer 11/25/2026 15:34'
}
SRFrame >> viewSkipped [

	viewsDone := viewsDone + 1.
]

{ #category : #accessing }
SRFrame >> world [

	^ world
]

{ #category : #accessing }
SRFrame >> world: aSRWorld [

	world := aSRWorld
]
