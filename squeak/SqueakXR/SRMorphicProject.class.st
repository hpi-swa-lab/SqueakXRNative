Class {
	#name : #SRMorphicProject,
	#superclass : #MorphicProject,
	#instVars : [
		'startSemaphore'
	],
	#category : #'SqueakXR-Morphic'
}

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:08'
}
SRMorphicProject >> initialize [

	super initialize.
	self installPasteUpAsWorld: (SRPasteUpMorph new).
	startSemaphore := Semaphore new.
	self world
		when: #aboutToEnterWorld
		send: #signalStart
		to: self
]

{
	#category : #debugging,
	#'squeak_changestamp' : 'lege 7/15/2026 16:16'
}
SRMorphicProject >> openDebuggerWindow: windowOrModel [
	"In XR mode, do not open debugger windows as they crash the render loop.
	 Log the error to the Transcript instead."
	| world label |
	world := SRWorld allInstances detect: [:w | w isRunning] ifNone: [nil].
	(world notNil and: [world isXR]) ifTrue: [
		label := [windowOrModel label] on: Error do: ['(unknown error)'].
		Transcript cr; show: '*** XR error (debugger suppressed): ', label.
		^ self].
	^ super openDebuggerWindow: windowOrModel
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:37'
}
SRMorphicProject >> showZoom [

	^ false
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/23/2026 16:09'
}
SRMorphicProject >> signalStart [

	self world color: Color midnight.
	startSemaphore signal
]

{
	#category : #'as yet unclassified',
	#'squeak_changestamp' : 'lege 2/19/2026 12:56'
}
SRMorphicProject >> waitForStart [

	startSemaphore wait
]
